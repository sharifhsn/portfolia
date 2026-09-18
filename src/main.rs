mod static_export;

use askama::Template;
use axum::{
    Router,
    extract::{Path, State},
    http::{StatusCode, header},
    response::{Html, IntoResponse, Redirect, Response},
    routing::get,
};
use serde::Deserialize;
use std::{
    collections::{BTreeMap, BTreeSet},
    fs,
    path::Path as FilePath,
    sync::Arc,
};
use toml::Value as TomlValue;
use tower_http::services::ServeDir;

const SITE_ORIGIN: &str = "https://sharifhsn.dev";
const SITE_NAME: &str = "Sharif Haason";
const MIN_VISIBLE_TAG_COUNT: usize = 5;
const REQUESTED_VISIBLE_TAGS: &[&str] = &[
    "Computational Methods",
    "Fixed Income",
    "Credit",
    "Probability Theory",
    "FX",
    "Stochastic Calculus",
    "Risk Management",
];

#[derive(Template)]
#[template(path = "site.html")]
struct Site<'a> {
    page: &'a str,
    title: &'a str,
    description: &'a str,
    canonical_url: &'a str,
    structured_data: &'a str,
    projects: &'a [Project],
    resume_html: &'a str,
    pdf_available: bool,
    docx_available: bool,
    photo_available: bool,
}

#[derive(Clone)]
struct BlogPost {
    slug: String,
    title: String,
    date: String,
    date_display: String,
    published_at: Option<String>,
    updated_at: Option<String>,
    description: String,
    tags: Vec<String>,
    categories: Vec<String>,
    display_tags: Vec<String>,
    tag_keys: String,
    search_text: String,
    source: String,
    source_url: String,
    body_markdown: String,
    body_html: String,
    word_count: usize,
    has_math: bool,
    sort_key: String,
}

#[derive(Clone)]
struct BlogTag {
    name: String,
    count: usize,
}

struct BlogTagGroup {
    name: String,
    tags: Vec<BlogTag>,
}

#[derive(Clone, Deserialize)]
struct Project {
    slug: String,
    name: String,
    kind: String,
    dates: String,
    technologies: String,
    summary: String,
    details: Vec<String>,
}

#[derive(Deserialize)]
struct ProjectDocument {
    projects: Vec<Project>,
}

#[derive(Template)]
#[template(path = "blog.html")]
struct BlogIndex<'a> {
    posts: &'a [BlogPost],
    total: usize,
    tag_groups: &'a [BlogTagGroup],
    canonical_url: &'a str,
    structured_data: &'a str,
}

#[derive(Template)]
#[template(path = "article.html")]
struct BlogArticle<'a> {
    post: &'a BlogPost,
    canonical_url: &'a str,
    structured_data: &'a str,
    previous: Option<&'a BlogPost>,
    next: Option<&'a BlogPost>,
    position: usize,
    total: usize,
}

fn site_url(path: &str) -> String {
    format!("{SITE_ORIGIN}{}", canonical_path(path))
}

fn canonical_path(path: &str) -> String {
    if path == "/"
        || path.ends_with('/')
        || path.rsplit('/').next().is_some_and(|part| {
            [".json", ".xml", ".txt", ".pdf", ".docx"]
                .iter()
                .any(|suffix| part.ends_with(suffix))
        })
    {
        path.to_owned()
    } else {
        format!("{path}/")
    }
}

fn site_path(page: &str) -> &'static str {
    match page {
        "home" => "/",
        "blog" => "/blog/",
        "projects" => "/projects/",
        "resume" => "/resume/",
        _ => "/",
    }
}

fn page_title(page: &str) -> &'static str {
    match page {
        "blog" => "Writing | Sharif Haason",
        "projects" => "Projects | Sharif Haason",
        "resume" => "Resume | Sharif Haason",
        _ => SITE_NAME,
    }
}

fn page_description(page: &str) -> &'static str {
    match page {
        "blog" => "Long-form writing, course notes, and technical explanations by Sharif Haason.",
        "projects" => "Selected software, research, and practical tools by Sharif Haason.",
        "resume" => {
            "The professional resume of Sharif Haason, a product engineer at Monark Markets."
        }
        _ => {
            "Sharif Haason is a product engineer at Monark Markets writing about Rust, compiler systems, mathematical research, and practical tools."
        }
    }
}

fn safe_json(value: &serde_json::Value) -> String {
    serde_json::to_string(value)
        .expect("structured data should serialize")
        .replace('<', "\\u003c")
        .replace('>', "\\u003e")
        .replace('&', "\\u0026")
}

fn person_json_ld() -> serde_json::Value {
    serde_json::json!({
        "@type": "Person",
        "@id": format!("{SITE_ORIGIN}/#person"),
        "name": SITE_NAME,
        "url": SITE_ORIGIN,
        "jobTitle": "Product Engineer",
        "worksFor": {"@type": "Organization", "name": "Monark Markets"},
        "sameAs": [
            "https://www.linkedin.com/in/sharif-haason/",
            "https://github.com/sharifhsn/"
        ],
        "knowsAbout": [
            "Rust", "compiler systems", "mathematical research",
            "quantitative finance", "practical software tools"
        ]
    })
}

fn page_json_ld(canonical_url: &str, page: &str) -> String {
    let page_type = if page == "home" {
        "ProfilePage"
    } else {
        "WebPage"
    };
    safe_json(&serde_json::json!({
        "@context": "https://schema.org",
        "@graph": [
            person_json_ld(),
            {
                "@type": "WebSite",
                "@id": format!("{SITE_ORIGIN}/#website"),
                "url": SITE_ORIGIN,
                "name": SITE_NAME,
                "publisher": {"@id": format!("{SITE_ORIGIN}/#person")}
            },
            {
                "@type": page_type,
                "@id": format!("{canonical_url}#webpage"),
                "url": canonical_url,
                "name": page_title(page),
                "description": page_description(page),
                "isPartOf": {"@id": format!("{SITE_ORIGIN}/#website")},
                "about": {"@id": format!("{SITE_ORIGIN}/#person")},
                "inLanguage": "en-US"
            }
        ]
    }))
}

fn projects_json_ld(canonical_url: &str, projects: &[Project]) -> String {
    let items = projects
        .iter()
        .enumerate()
        .map(|(index, project)| {
            serde_json::json!({
                "@type": "ListItem",
                "position": index + 1,
                "url": format!("{canonical_url}#project-{}", project.slug),
                "item": {
                    "@type": "CreativeWork",
                    "@id": format!("{canonical_url}#project-{}", project.slug),
                    "name": project.name,
                    "description": project.summary,
                    "keywords": project.technologies,
                    "author": {"@id": format!("{SITE_ORIGIN}/#person")}
                }
            })
        })
        .collect::<Vec<_>>();
    safe_json(&serde_json::json!({
        "@context": "https://schema.org",
        "@graph": [
            person_json_ld(),
            {
                "@type": "WebSite",
                "@id": format!("{SITE_ORIGIN}/#website"),
                "url": SITE_ORIGIN,
                "name": SITE_NAME,
                "publisher": {"@id": format!("{SITE_ORIGIN}/#person")}
            },
            {
                "@type": "CollectionPage",
                "@id": format!("{canonical_url}#webpage"),
                "url": canonical_url,
                "name": page_title("projects"),
                "description": page_description("projects"),
                "isPartOf": {"@id": format!("{SITE_ORIGIN}/#website")},
                "about": {"@id": format!("{SITE_ORIGIN}/#person")},
                "mainEntity": {
                    "@type": "ItemList",
                    "numberOfItems": projects.len(),
                    "itemListElement": items
                },
                "inLanguage": "en-US"
            }
        ]
    }))
}

fn article_json_ld(post: &BlogPost, canonical_url: &str) -> String {
    let mut article = serde_json::json!({
        "@context": "https://schema.org",
        "@type": "Article",
        "@id": format!("{canonical_url}#article"),
        "url": canonical_url,
        "headline": post.title,
        "description": post.description,
        "datePublished": post.published_at.as_deref().unwrap_or(&post.date),
        "author": {"@id": format!("{SITE_ORIGIN}/#person")},
        "publisher": {"@id": format!("{SITE_ORIGIN}/#person")},
        "mainEntityOfPage": {"@id": canonical_url},
        "articleSection": post.tags,
        "genre": post.categories,
        "keywords": post.tags,
        "wordCount": post.word_count,
        "isPartOf": {"@id": format!("{SITE_ORIGIN}/#website")},
        "inLanguage": "en-US",
        "isAccessibleForFree": true
    });
    if let Some(updated_at) = &post.updated_at {
        article["dateModified"] = serde_json::Value::String(updated_at.clone());
    }
    if !post.source_url.is_empty() {
        article["citation"] = serde_json::Value::String(post.source_url.clone());
    }
    safe_json(&article)
}

fn clean_inline_text(source: &str) -> String {
    source
        .split_whitespace()
        .collect::<Vec<_>>()
        .join(" ")
        .replace('|', "\\|")
}

fn summarize_markdown(source: &str, title: &str) -> String {
    let paragraph = source
        .split("\n\n")
        .map(str::trim)
        .find(|block| {
            !block.is_empty()
                && !block.starts_with('#')
                && !block.starts_with("```")
                && !block.starts_with("~~~")
        })
        .unwrap_or(title);
    let summary = paragraph
        .replace("**", "")
        .replace("__", "")
        .replace(['*', '`', '>'], "")
        .split_whitespace()
        .collect::<Vec<_>>()
        .join(" ");
    let summary = if summary.is_empty() { title } else { &summary };
    let mut truncated = summary.chars().take(180).collect::<String>();
    if summary.chars().count() > 180 {
        truncated.push('…');
    }
    truncated
}

fn xml_escape(source: &str) -> String {
    source
        .replace('&', "&amp;")
        .replace('<', "&lt;")
        .replace('>', "&gt;")
        .replace('"', "&quot;")
        .replace('\'', "&apos;")
}

fn text_response(content_type: &'static str, body: String) -> Response {
    ([(header::CONTENT_TYPE, content_type)], body).into_response()
}

fn json_response(value: &serde_json::Value) -> Response {
    let body = serde_json::to_string(value).expect("JSON endpoint should serialize");
    text_response("application/json; charset=utf-8", body)
}

fn robots_txt_content() -> String {
    format!(
        "# Public portfolio; crawlers may access the site.\nUser-agent: *\nAllow: /\nSitemap: {SITE_ORIGIN}/sitemap.xml\n"
    )
}

fn sitemap_xml(posts: &[BlogPost]) -> String {
    let mut xml = String::from(
        "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n",
    );
    for path in ["/", "/blog", "/projects", "/resume"] {
        xml.push_str("  <url><loc>");
        xml.push_str(&xml_escape(&site_url(path)));
        xml.push_str("</loc>");
        xml.push_str("</url>\n");
    }
    for post in posts {
        xml.push_str("  <url><loc>");
        xml.push_str(&xml_escape(&site_url(&format!("/blog/{}", post.slug))));
        xml.push_str("</loc><lastmod>");
        xml.push_str(&xml_escape(&post.date));
        xml.push_str("</lastmod></url>\n");
    }
    xml.push_str("</urlset>\n");
    xml
}

fn llms_txt(posts: &[BlogPost]) -> String {
    let mut text = String::from(
        "# Sharif Haason\n\n> Product engineer at Monark Markets writing about Rust, compiler systems, mathematical research, quantitative finance, and practical tools. This is the canonical public site; each article carries its date, topics, and source attribution.\n\n## Start here\n\n",
    );
    for (label, path, description) in [
        ("Home", "/", page_description("home")),
        ("Writing index", "/blog", page_description("blog")),
        ("Projects", "/projects", page_description("projects")),
        ("Resume", "/resume", page_description("resume")),
        (
            "RSS feed",
            "/feed.xml",
            "Atom feed for the writing archive.",
        ),
        (
            "JSON feed",
            "/feed.json",
            "JSON Feed 1.1 representation of the writing archive.",
        ),
        (
            "Structured writing index",
            "/api/posts.json",
            "JSON metadata for every article, with stable article-data URLs.",
        ),
        (
            "Structured projects",
            "/api/projects.json",
            "JSON metadata for the selected projects shown on the projects page.",
        ),
        (
            "Structured profile",
            "/api/profile.json",
            "Public profile, social links, resume downloads, and discovery URLs.",
        ),
        (
            "Agent manifest",
            "/.well-known/agent.json",
            "Read-only discovery manifest for machine clients.",
        ),
        (
            "OpenAPI description",
            "/api/openapi.json",
            "OpenAPI 3.1 description of the structured read endpoints.",
        ),
        (
            "Full writing corpus",
            "/llms-full.txt",
            "The complete public writing corpus as Markdown with article metadata.",
        ),
        (
            "Sitemap",
            "/sitemap.xml",
            "Machine-readable list of canonical pages.",
        ),
    ] {
        text.push_str(&format!(
            "- [{}]({}): {}\n",
            label,
            site_url(path),
            description
        ));
    }
    text.push_str("\n## Writing\n\n");
    for post in posts {
        let description = if post.description.is_empty() {
            "Article with date and topic metadata on its page."
        } else {
            &post.description
        };
        let published = post.published_at.as_deref().unwrap_or(&post.date);
        let source = if post.source.is_empty() {
            "unspecified"
        } else {
            &post.source
        };
        let tags = if post.tags.is_empty() {
            String::new()
        } else {
            format!(" Topics: {}.", post.tags.join(", "))
        };
        text.push_str(&format!(
            "- [{}]({}): {} Date: {}. Source: {}.{}\n",
            clean_inline_text(&post.title),
            site_url(&format!("/blog/{}", post.slug)),
            clean_inline_text(description),
            clean_inline_text(published),
            clean_inline_text(source),
            tags
        ));
    }
    text
}

fn llms_full_txt(posts: &[BlogPost]) -> String {
    let mut text = String::from(
        "# Sharif Haason — full writing corpus\n\nThis is the complete public writing archive in Markdown. The canonical page for each article and its structured JSON representation are included in the metadata block.\n\n",
    );
    for post in posts {
        let published = post.published_at.as_deref().unwrap_or(&post.date);
        let categories = if post.categories.is_empty() {
            "None".to_owned()
        } else {
            clean_inline_text(&post.categories.join(", "))
        };
        let source_url = if post.source_url.is_empty() {
            "None".to_owned()
        } else {
            post.source_url.clone()
        };
        text.push_str(&format!(
            "## {}\n\n- URL: {}\n- Structured data: {}\n- Description: {}\n- Date: {}\n- Exact published timestamp: {}\n- Topics: {}\n- Categories: {}\n- Source: {}\n- Source URL: {}\n\n{}\n\n",
            clean_inline_text(&post.title),
            site_url(&format!("/blog/{}", post.slug)),
            site_url(&format!("/api/posts/{}.json", post.slug)),
            clean_inline_text(&post.description),
            clean_inline_text(&post.date),
            clean_inline_text(published),
            if post.tags.is_empty() {
                "None".to_owned()
            } else {
                clean_inline_text(&post.tags.join(", "))
            },
            categories,
            clean_inline_text(&post.source),
            source_url,
            post.body_markdown.trim()
        ));
    }
    text
}

fn post_summary_json(post: &BlogPost) -> serde_json::Value {
    let mut value = serde_json::json!({
        "slug": post.slug,
        "url": site_url(&format!("/blog/{}", post.slug)),
        "dataUrl": site_url(&format!("/api/posts/{}.json", post.slug)),
        "title": post.title,
        "description": post.description,
        "date": post.date,
        "datePublished": post.published_at.as_deref().unwrap_or(&post.date),
        "tags": post.tags,
        "categories": post.categories,
        "source": post.source,
        "sourceUrl": if post.source_url.is_empty() { serde_json::Value::Null } else { serde_json::Value::String(post.source_url.clone()) },
        "wordCount": post.word_count,
    });
    if let Some(published_at) = &post.published_at {
        value["publishedAt"] = serde_json::Value::String(published_at.clone());
    }
    if let Some(updated_at) = &post.updated_at {
        value["updatedAt"] = serde_json::Value::String(updated_at.clone());
        value["dateModified"] = serde_json::Value::String(updated_at.clone());
    }
    value
}

fn post_json(post: &BlogPost) -> serde_json::Value {
    let mut value = post_summary_json(post);
    value["contentMarkdown"] = serde_json::Value::String(post.body_markdown.clone());
    value["contentHtml"] = serde_json::Value::String(post.body_html.clone());
    value
}

fn api_posts_json(posts: &[BlogPost]) -> serde_json::Value {
    serde_json::json!({
        "version": "1",
        "site": SITE_ORIGIN,
        "indexUrl": site_url("/api/posts.json"),
        "count": posts.len(),
        "items": posts.iter().map(post_summary_json).collect::<Vec<_>>()
    })
}

fn project_json(project: &Project, canonical_url: &str) -> serde_json::Value {
    serde_json::json!({
        "slug": project.slug,
        "url": format!("{canonical_url}#project-{}", project.slug),
        "name": project.name,
        "kind": project.kind,
        "dates": project.dates,
        "technologies": project.technologies,
        "summary": project.summary,
        "details": project.details
    })
}

fn api_projects_json(projects: &[Project]) -> serde_json::Value {
    let canonical_url = site_url("/projects");
    serde_json::json!({
        "version": "1",
        "site": SITE_ORIGIN,
        "pageUrl": canonical_url,
        "count": projects.len(),
        "items": projects.iter().map(|project| project_json(project, &canonical_url)).collect::<Vec<_>>()
    })
}

fn api_profile_json() -> serde_json::Value {
    serde_json::json!({
        "version": "1",
        "site": SITE_ORIGIN,
        "agentManifestUrl": site_url("/.well-known/agent.json"),
        "openApiUrl": site_url("/api/openapi.json"),
        "profileUrl": site_url("/"),
        "person": person_json_ld(),
        "pages": [
            {"name": "Home", "url": site_url("/")},
            {"name": "Writing", "url": site_url("/blog")},
            {"name": "Projects", "url": site_url("/projects")},
            {"name": "Resume", "url": site_url("/resume")}
        ],
        "resume": {
            "htmlUrl": site_url("/resume"),
            "pdfUrl": site_url("/static/resume/sharif-haason.pdf"),
            "docxUrl": site_url("/static/resume/sharif-haason.docx")
        },
        "writingIndexUrl": site_url("/api/posts.json"),
        "projectsIndexUrl": site_url("/api/projects.json")
    })
}

fn agent_manifest_json() -> serde_json::Value {
    serde_json::json!({
        "version": "1",
        "name": "Sharif Haason public portfolio",
        "description": page_description("home"),
        "site": site_url("/"),
        "access": "public-read-only",
        "authentication": "none",
        "mutations": false,
        "discovery": [
            {"rel": "llms", "url": site_url("/llms.txt"), "description": "Concise site map and article descriptions."},
            {"rel": "llms-full", "url": site_url("/llms-full.txt"), "description": "Complete public writing corpus in Markdown."},
            {"rel": "openapi", "url": site_url("/api/openapi.json"), "description": "OpenAPI 3.1 description of structured read endpoints."},
            {"rel": "posts", "url": site_url("/api/posts.json"), "description": "Stable article metadata index."},
            {"rel": "projects", "url": site_url("/api/projects.json"), "description": "Structured project summaries."},
            {"rel": "profile", "url": site_url("/api/profile.json"), "description": "Public profile and resume links."},
            {"rel": "sitemap", "url": site_url("/sitemap.xml"), "description": "Canonical URL inventory."},
            {"rel": "feed", "url": site_url("/feed.json"), "description": "JSON Feed 1.1 article feed."}
        ]
    })
}

fn openapi_json() -> serde_json::Value {
    serde_json::json!({
        "openapi": "3.1.0",
        "info": {
            "title": "Sharif Haason public portfolio",
            "version": "1",
            "description": "Read-only machine-readable access to Sharif Haason's public writing, projects, and profile. HTML pages remain the canonical human presentation."
        },
        "servers": [{"url": SITE_ORIGIN}],
        "paths": {
            "/api/posts.json": {
                "get": {
                    "operationId": "listPosts",
                    "summary": "List all writing",
                    "responses": {"200": {"description": "Article metadata index", "content": {"application/json": {"schema": {"$ref": "#/components/schemas/PostIndex"}}}}}
                }
            },
            "/api/posts/{slug}.json": {
                "get": {
                    "operationId": "getPost",
                    "summary": "Get one article and its full public content",
                    "parameters": [{"name": "slug", "in": "path", "required": true, "schema": {"type": "string"}}],
                    "responses": {
                        "200": {"description": "Article data", "content": {"application/json": {"schema": {"$ref": "#/components/schemas/Post"}}}},
                        "404": {"description": "Unknown article slug"}
                    }
                }
            },
            "/api/projects.json": {
                "get": {
                    "operationId": "listProjects",
                    "summary": "List selected projects",
                    "responses": {"200": {"description": "Project index", "content": {"application/json": {"schema": {"$ref": "#/components/schemas/ProjectIndex"}}}}}
                }
            },
            "/api/profile.json": {
                "get": {
                    "operationId": "getProfile",
                    "summary": "Get the public profile and discovery links",
                    "responses": {"200": {"description": "Public profile", "content": {"application/json": {"schema": {"type": "object"}}}}}
                }
            },
            "/feed.json": {
                "get": {
                    "operationId": "getJsonFeed",
                    "summary": "Get the JSON Feed 1.1 writing feed",
                    "responses": {"200": {"description": "JSON Feed 1.1", "content": {"application/feed+json": {"schema": {"type": "object"}}}}}
                }
            },
            "/feed.xml": {
                "get": {
                    "operationId": "getAtomFeed",
                    "summary": "Get the Atom writing feed",
                    "responses": {"200": {"description": "Atom feed", "content": {"application/atom+xml": {"schema": {"type": "string"}}}}}
                }
            },
            "/llms.txt": {
                "get": {
                    "operationId": "getLlmGuide",
                    "summary": "Get the concise LLM discovery guide",
                    "responses": {"200": {"description": "Plain-text discovery guide", "content": {"text/plain": {"schema": {"type": "string"}}}}}
                }
            },
            "/llms-full.txt": {
                "get": {
                    "operationId": "getFullCorpus",
                    "summary": "Get the complete public writing corpus",
                    "responses": {"200": {"description": "Plain-text Markdown corpus", "content": {"text/plain": {"schema": {"type": "string"}}}}}
                }
            }
        },
        "components": {
            "schemas": {
                "PostSummary": {
                    "type": "object",
                    "required": ["slug", "url", "dataUrl", "title", "description", "date", "datePublished", "tags", "categories", "source", "wordCount"],
                    "properties": {
                        "slug": {"type": "string"},
                        "url": {"type": "string", "format": "uri"},
                        "dataUrl": {"type": "string", "format": "uri"},
                        "title": {"type": "string"},
                        "description": {"type": "string"},
                        "date": {"type": "string", "format": "date"},
                        "datePublished": {"type": "string"},
                        "dateModified": {"type": "string"},
                        "tags": {"type": "array", "items": {"type": "string"}},
                        "categories": {"type": "array", "items": {"type": "string"}},
                        "source": {"type": "string"},
                        "sourceUrl": {"type": ["string", "null"], "format": "uri"},
                        "wordCount": {"type": "integer", "minimum": 0}
                    }
                },
                "Post": {
                    "allOf": [
                        {"$ref": "#/components/schemas/PostSummary"},
                        {"type": "object", "required": ["contentMarkdown", "contentHtml"], "properties": {"contentMarkdown": {"type": "string"}, "contentHtml": {"type": "string"}}}
                    ]
                },
                "PostIndex": {
                    "type": "object",
                    "required": ["version", "site", "indexUrl", "count", "items"],
                    "properties": {
                        "version": {"type": "string"},
                        "site": {"type": "string", "format": "uri"},
                        "indexUrl": {"type": "string", "format": "uri"},
                        "count": {"type": "integer", "minimum": 0},
                        "items": {"type": "array", "items": {"$ref": "#/components/schemas/PostSummary"}}
                    }
                },
                "Project": {
                    "type": "object",
                    "required": ["slug", "url", "name", "kind", "dates", "technologies", "summary", "details"],
                    "properties": {
                        "slug": {"type": "string"},
                        "url": {"type": "string", "format": "uri"},
                        "name": {"type": "string"},
                        "kind": {"type": "string"},
                        "dates": {"type": "string"},
                        "technologies": {"type": "string"},
                        "summary": {"type": "string"},
                        "details": {"type": "array", "items": {"type": "string"}}
                    }
                },
                "ProjectIndex": {
                    "type": "object",
                    "required": ["version", "site", "pageUrl", "count", "items"],
                    "properties": {
                        "version": {"type": "string"},
                        "site": {"type": "string", "format": "uri"},
                        "pageUrl": {"type": "string", "format": "uri"},
                        "count": {"type": "integer", "minimum": 0},
                        "items": {"type": "array", "items": {"$ref": "#/components/schemas/Project"}}
                    }
                }
            }
        }
    })
}

fn api_post_json(post: &BlogPost) -> serde_json::Value {
    let mut value = post_json(post);
    value["version"] = serde_json::Value::String("1".to_owned());
    value["site"] = serde_json::Value::String(SITE_ORIGIN.to_owned());
    value
}

fn feed_json(posts: &[BlogPost]) -> serde_json::Value {
    serde_json::json!({
        "version": "https://jsonfeed.org/version/1.1",
        "title": "Sharif Haason — Writing",
        "home_page_url": site_url("/blog"),
        "feed_url": site_url("/feed.json"),
        "description": page_description("blog"),
        "authors": [{"name": SITE_NAME, "url": SITE_ORIGIN}],
        "items": posts.iter().map(|post| {
            let mut item = serde_json::json!({
                "id": site_url(&format!("/blog/{}", post.slug)),
                "url": site_url(&format!("/blog/{}", post.slug)),
                "title": post.title,
                "summary": post.description,
                "content_html": post.body_html,
                "date_published": atom_timestamp(post.published_at.as_deref().unwrap_or(&post.date)),
                "author": {"name": SITE_NAME, "url": SITE_ORIGIN},
                "tags": post.tags,
                "_portfolia": {
                    "date": post.date,
                    "categories": post.categories,
                    "source": post.source,
                    "source_url": if post.source_url.is_empty() { serde_json::Value::Null } else { serde_json::Value::String(post.source_url.clone()) }
                }
            });
            if let Some(updated_at) = &post.updated_at {
                item["date_modified"] = serde_json::Value::String(atom_timestamp(updated_at));
            }
            if !post.source_url.is_empty() {
                item["external_url"] = serde_json::Value::String(post.source_url.clone());
            }
            item
        }).collect::<Vec<_>>()
    })
}

fn feed_xml(posts: &[BlogPost]) -> String {
    let mut xml = String::from(
        "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<feed xmlns=\"http://www.w3.org/2005/Atom\">\n",
    );
    xml.push_str(&format!(
        "  <title>{}</title>\n  <link href=\"{}\" rel=\"alternate\"/>\n  <link href=\"{}\" rel=\"self\"/>\n  <id>{}</id>\n",
        xml_escape("Sharif Haason — Writing"),
        xml_escape(&site_url("/blog")),
        xml_escape(&site_url("/feed.xml")),
        xml_escape(&site_url("/blog"))
    ));
    xml.push_str(&format!(
        "  <author><name>{}</name><uri>{}</uri></author>\n",
        xml_escape(SITE_NAME),
        xml_escape(SITE_ORIGIN)
    ));
    if let Some(post) = posts.first() {
        xml.push_str(&format!(
            "  <updated>{}</updated>\n",
            xml_escape(&atom_timestamp(
                post.published_at.as_deref().unwrap_or(&post.date),
            ))
        ));
    }
    for post in posts {
        let url = site_url(&format!("/blog/{}", post.slug));
        let published = atom_timestamp(post.published_at.as_deref().unwrap_or(&post.date));
        let updated = post
            .updated_at
            .as_deref()
            .map(atom_timestamp)
            .unwrap_or_else(|| published.clone());
        xml.push_str(&format!(
            "  <entry><title>{}</title><link href=\"{}\"/><id>{}</id><published>{}</published><updated>{}</updated><author><name>{}</name><uri>{}</uri></author><summary>{}</summary>",
            xml_escape(&post.title),
            xml_escape(&url),
            xml_escape(&url),
            xml_escape(&published),
            xml_escape(&updated),
            xml_escape(SITE_NAME),
            xml_escape(SITE_ORIGIN),
            xml_escape(&post.description)
        ));
        for tag in &post.tags {
            xml.push_str(&format!("<category term=\"{}\"/>", xml_escape(tag)));
        }
        if !post.source_url.is_empty() {
            xml.push_str(&format!(
                "<link href=\"{}\" rel=\"via\"/>",
                xml_escape(&post.source_url)
            ));
        }
        xml.push_str("</entry>\n");
    }
    xml.push_str("</feed>\n");
    xml
}

fn atom_timestamp(date: &str) -> String {
    if date.len() == 10 {
        format!("{}T00:00:00Z", date)
    } else {
        date.to_owned()
    }
}

fn toml_string(value: &TomlValue) -> Option<String> {
    value
        .as_str()
        .map(str::to_owned)
        .or_else(|| value.as_datetime().map(ToString::to_string))
}

fn toml_strings(value: Option<&TomlValue>) -> Vec<String> {
    value
        .and_then(TomlValue::as_array)
        .into_iter()
        .flatten()
        .filter_map(TomlValue::as_str)
        .map(str::to_owned)
        .collect()
}

fn toml_optional_string(metadata: &TomlValue, key: &str) -> Option<String> {
    metadata
        .get(key)
        .and_then(toml_string)
        .filter(|value| !value.trim().is_empty())
}

fn render_markdown(source: &str) -> String {
    let (protected, formulas) = protect_math(source);
    let mut html = ammonia::clean(&markdown::to_html(&protected));
    for (placeholder, formula) in formulas {
        html = html.replace(&placeholder, &escape_html_text(&formula));
    }
    html
}

fn protect_math(source: &str) -> (String, Vec<(String, String)>) {
    let bytes = source.as_bytes();
    let mut cursor = 0;
    let mut output = String::with_capacity(source.len());
    let mut formulas = Vec::new();
    let mut code_fence: Option<u8> = None;

    while cursor < source.len() {
        if cursor == 0 || bytes[cursor - 1] == b'\n' {
            let line_end = source[cursor..]
                .find('\n')
                .map(|offset| cursor + offset + 1)
                .unwrap_or(source.len());
            let content_end = if line_end > cursor && bytes[line_end - 1] == b'\n' {
                line_end - 1
            } else {
                line_end
            };
            let line = source[cursor..content_end].trim_start_matches(' ');
            let line_bytes = line.as_bytes();
            let fence = if line_bytes.starts_with(&[b'\x60'; 3]) {
                Some(b'\x60')
            } else if line.starts_with("~~~") {
                Some(b'~')
            } else {
                None
            };

            if let Some(active_fence) = code_fence {
                output.push_str(&source[cursor..line_end]);
                if fence == Some(active_fence) {
                    code_fence = None;
                }
                cursor = line_end;
                continue;
            }
            if let Some(fence) = fence {
                code_fence = Some(fence);
                output.push_str(&source[cursor..line_end]);
                cursor = line_end;
                continue;
            }
        }

        if bytes[cursor] == b'\x60' {
            let mut run_end = cursor;
            while run_end < source.len() && bytes[run_end] == b'\x60' {
                run_end += 1;
            }
            let ticks = &source[cursor..run_end];
            if let Some(offset) = source[run_end..].find(ticks) {
                let end = run_end + offset + ticks.len();
                output.push_str(&source[cursor..end]);
                cursor = end;
                continue;
            }
        }

        if source[cursor..].starts_with("$$") {
            let content_start = cursor + 2;
            if let Some(offset) = source[content_start..].find("$$") {
                let content_end = content_start + offset;
                let end = content_end + 2;
                let formula = format!(
                    "{}{}{}",
                    "$$",
                    normalize_tex_math(&source[content_start..content_end]),
                    "$$"
                );
                let placeholder = format!("PORTFOLIAMATH{}END", formulas.len());
                output.push_str(&placeholder);
                formulas.push((placeholder, formula));
                cursor = end;
                continue;
            }
        }

        if bytes[cursor] == b'\\' {
            let mut delimiter_end = cursor;
            while delimiter_end < source.len() && bytes[delimiter_end] == b'\\' {
                delimiter_end += 1;
            }
            if delimiter_end < source.len()
                && (bytes[delimiter_end] == b'(' || bytes[delimiter_end] == b'[')
            {
                let opener = bytes[delimiter_end];
                let closer = if opener == b'(' { b')' } else { b']' };
                if let Some((close_start, end)) =
                    find_inline_math_close(source, delimiter_end + 1, closer)
                {
                    let open_char = opener as char;
                    let close_char = closer as char;
                    let content = normalize_tex_math(&source[delimiter_end + 1..close_start]);
                    let formula = format!("\\{open_char}{content}\\{close_char}");
                    let placeholder = format!("PORTFOLIAMATH{}END", formulas.len());
                    output.push_str(&placeholder);
                    formulas.push((placeholder, formula));
                    cursor = end;
                    continue;
                }
            }
        }

        let character = source[cursor..]
            .chars()
            .next()
            .expect("valid UTF-8 boundary");
        output.push(character);
        cursor += character.len_utf8();
    }

    (output, formulas)
}

fn find_inline_math_close(source: &str, mut cursor: usize, closer: u8) -> Option<(usize, usize)> {
    let bytes = source.as_bytes();
    while cursor < bytes.len() {
        if bytes[cursor] == b'\\' {
            let close_start = cursor;
            while cursor < bytes.len() && bytes[cursor] == b'\\' {
                cursor += 1;
            }
            if cursor < bytes.len() && bytes[cursor] == closer {
                return Some((close_start, cursor + 1));
            }
            continue;
        }
        let character = source[cursor..].chars().next()?;
        cursor += character.len_utf8();
    }
    None
}

fn normalize_tex_math(source: &str) -> String {
    let mut normalized = String::with_capacity(source.len());
    let mut characters = source.chars().peekable();
    while let Some(character) = characters.next() {
        if character == '\\' {
            let mut run: usize = 1;
            while characters.peek() == Some(&'\\') {
                characters.next();
                run += 1;
            }
            normalized.push_str(&"\\".repeat(run.div_ceil(2)));
        } else {
            normalized.push(character);
        }
    }

    let mut unescaped = String::with_capacity(normalized.len());
    let mut characters = normalized.chars().peekable();
    while let Some(character) = characters.next() {
        if character == '\\'
            && characters
                .peek()
                .is_some_and(|next| "=+-<>[]()*_&.".contains(*next))
        {
            unescaped.push(characters.next().unwrap());
        } else {
            unescaped.push(character);
        }
    }
    unescaped
}

fn escape_html_text(source: &str) -> String {
    source
        .replace('&', "&amp;")
        .replace('<', "&lt;")
        .replace('>', "&gt;")
}

fn load_blog_posts() -> Result<Vec<BlogPost>, StatusCode> {
    let blog_dir = FilePath::new(env!("CARGO_MANIFEST_DIR")).join("content/blog");
    let pattern = format!("{}/*.md", blog_dir.display());
    let entries = glob::glob(&pattern).map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;
    let mut posts = Vec::new();

    for entry in entries {
        let path = entry.map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;
        let source = fs::read_to_string(&path).map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;
        let mut sections = source.splitn(3, "+++");
        if !sections.next().unwrap_or_default().trim().is_empty() {
            return Err(StatusCode::INTERNAL_SERVER_ERROR);
        }
        let front_matter = sections.next().ok_or(StatusCode::INTERNAL_SERVER_ERROR)?;
        let markdown_body = sections.next().ok_or(StatusCode::INTERNAL_SERVER_ERROR)?;
        let metadata: TomlValue =
            toml::from_str(front_matter).map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;
        let title = metadata
            .get("title")
            .and_then(toml_string)
            .ok_or(StatusCode::INTERNAL_SERVER_ERROR)?;
        let date = metadata
            .get("date")
            .and_then(toml_string)
            .ok_or(StatusCode::INTERNAL_SERVER_ERROR)?;
        let published_at = toml_optional_string(&metadata, "published_at");
        let updated_at = toml_optional_string(&metadata, "updated_at");
        let taxonomies = metadata.get("taxonomies");
        let categories = toml_strings(
            taxonomies
                .and_then(|table| table.get("categories"))
                .or_else(|| metadata.get("categories")),
        );
        let mut tags = toml_strings(
            taxonomies
                .and_then(|table| table.get("tags"))
                .or_else(|| metadata.get("tags")),
        );
        for category in &categories {
            if !tags.contains(category) {
                tags.push(category.clone());
            }
        }
        let source_name = metadata
            .get("source")
            .and_then(TomlValue::as_str)
            .unwrap_or("Archive")
            .to_owned();
        let source_url = metadata
            .get("source_url")
            .and_then(TomlValue::as_str)
            .unwrap_or_default()
            .to_owned();
        let metadata_description = metadata
            .get("description")
            .and_then(TomlValue::as_str)
            .unwrap_or_default()
            .to_owned();
        let slug = path
            .file_stem()
            .and_then(|name| name.to_str())
            .ok_or(StatusCode::INTERNAL_SERVER_ERROR)?
            .to_owned();
        let body = markdown_body.replace("<!-- more -->", "").trim().to_owned();
        let description = if metadata_description.trim().is_empty() {
            summarize_markdown(&body, &title)
        } else {
            metadata_description
        };
        let body_html = render_markdown(&body);
        let word_count = body.split_whitespace().count();
        let has_math = body.contains("$$") || body.contains("\\(") || body.contains("\\[");
        let sort_key = published_at.clone().unwrap_or_else(|| date.clone());
        let date_display = date.chars().take(10).collect();
        let tag_keys = tags.join("|");
        let search_text = format!("{} {} {}", title, description, tags.join(" "));
        posts.push(BlogPost {
            slug,
            title,
            date,
            date_display,
            published_at,
            updated_at,
            description,
            tags,
            categories,
            display_tags: Vec::new(),
            tag_keys,
            search_text,
            source: source_name,
            source_url,
            body_markdown: body,
            body_html,
            word_count,
            has_math,
            sort_key,
        });
    }

    posts.sort_by(|left, right| {
        right
            .sort_key
            .cmp(&left.sort_key)
            .then_with(|| left.title.cmp(&right.title))
    });

    let counts = tag_counts(&posts);
    for post in &mut posts {
        post.display_tags = post
            .tags
            .iter()
            .filter(|tag| {
                counts
                    .get(*tag)
                    .is_some_and(|count| tag_is_visible(tag, *count))
            })
            .cloned()
            .collect();
    }

    Ok(posts)
}

fn load_projects() -> Vec<Project> {
    toml::from_str::<ProjectDocument>(include_str!("../content/projects.toml"))
        .expect("project content should load")
        .projects
}

fn tag_is_visible(name: &str, count: usize) -> bool {
    count >= MIN_VISIBLE_TAG_COUNT || REQUESTED_VISIBLE_TAGS.contains(&name)
}

fn tag_counts(posts: &[BlogPost]) -> BTreeMap<String, usize> {
    let mut counts = BTreeMap::<String, usize>::new();
    for post in posts {
        let mut seen = BTreeSet::new();
        for tag in &post.tags {
            if seen.insert(tag) {
                *counts.entry(tag.clone()).or_default() += 1;
            }
        }
    }
    counts
}

fn tag_group_name(name: &str) -> &'static str {
    match name {
        "Computational Methods"
        | "Fixed Income"
        | "Credit"
        | "Credit Risk"
        | "Probability Theory"
        | "FX"
        | "Stochastic Calculus"
        | "Risk Management" => "Quantitative Finance",
        "Internet Technology"
        | "Principles of Programming Languages"
        | "Operating Systems Design"
        | "Rust" => "Computer Science",
        "Physics" => "Other",
        _ => "Other frequent topics",
    }
}

fn tag_group_order(name: &str) -> u8 {
    match name {
        "Quantitative Finance" => 0,
        "Computer Science" => 1,
        "Other" => 2,
        _ => 3,
    }
}

fn popular_tag_groups(posts: &[BlogPost]) -> Vec<BlogTagGroup> {
    let mut grouped_tags = BTreeMap::<String, Vec<BlogTag>>::new();
    for (name, count) in tag_counts(posts) {
        if !tag_is_visible(&name, count) {
            continue;
        }
        grouped_tags
            .entry(tag_group_name(&name).to_owned())
            .or_default()
            .push(BlogTag { name, count });
    }

    let mut groups: Vec<BlogTagGroup> = grouped_tags
        .into_iter()
        .map(|(name, mut tags)| {
            tags.sort_by(|left, right| left.name.cmp(&right.name));
            BlogTagGroup { name, tags }
        })
        .collect();
    groups.sort_by_key(|group| tag_group_order(&group.name));
    groups
}

fn render_blog_index(posts: &[BlogPost]) -> Result<Html<String>, StatusCode> {
    let tag_groups = popular_tag_groups(posts);
    let canonical_url = site_url("/blog");
    let structured_data = safe_json(&serde_json::json!({
        "@context": "https://schema.org",
        "@type": "CollectionPage",
        "@id": format!("{canonical_url}#webpage"),
        "url": canonical_url,
        "name": page_title("blog"),
        "description": page_description("blog"),
        "isPartOf": {"@id": format!("{SITE_ORIGIN}/#website")},
        "about": {"@id": format!("{SITE_ORIGIN}/#person")},
        "numberOfItems": posts.len(),
        "inLanguage": "en-US"
    }));

    BlogIndex {
        posts,
        total: posts.len(),
        tag_groups: &tag_groups,
        canonical_url: &canonical_url,
        structured_data: &structured_data,
    }
    .render()
    .map(Html)
    .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)
}

fn render_blog_article(posts: &[BlogPost], slug: &str) -> Result<Html<String>, StatusCode> {
    let position = posts
        .iter()
        .position(|post| post.slug == slug)
        .ok_or(StatusCode::NOT_FOUND)?;
    let post = &posts[position];
    let canonical_url = site_url(&format!("/blog/{}", post.slug));
    let structured_data = article_json_ld(post, &canonical_url);
    BlogArticle {
        post,
        canonical_url: &canonical_url,
        structured_data: &structured_data,
        previous: posts.get(position + 1),
        next: position.checked_sub(1).and_then(|index| posts.get(index)),
        position: position + 1,
        total: posts.len(),
    }
    .render()
    .map(Html)
    .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)
}

fn render_site(page: &str) -> Result<Html<String>, StatusCode> {
    if !["home", "projects", "resume"].contains(&page) {
        return Err(StatusCode::NOT_FOUND);
    }
    let resume_html = render_markdown(include_str!("../content/resume-current.md"));
    let projects = load_projects();
    let title = page_title(page);
    let description = page_description(page);
    let canonical_url = site_url(site_path(page));
    let structured_data = if page == "projects" {
        projects_json_ld(&canonical_url, &projects)
    } else {
        page_json_ld(&canonical_url, page)
    };
    Site {
        page,
        title,
        description,
        canonical_url: &canonical_url,
        structured_data: &structured_data,
        projects: &projects,
        resume_html: &resume_html,
        pdf_available: FilePath::new("static/resume/sharif-haason.pdf").is_file(),
        docx_available: FilePath::new("static/resume/sharif-haason.docx").is_file(),
        photo_available: FilePath::new("static/img/profile.jpg").is_file(),
    }
    .render()
    .map(Html)
    .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)
}

async fn home() -> Result<Html<String>, StatusCode> {
    render_site("home")
}

async fn projects() -> Result<Html<String>, StatusCode> {
    render_site("projects")
}

async fn resume() -> Result<Html<String>, StatusCode> {
    render_site("resume")
}

async fn blog_index(State(posts): State<Arc<Vec<BlogPost>>>) -> Result<Html<String>, StatusCode> {
    render_blog_index(posts.as_slice())
}

async fn blog_article(
    State(posts): State<Arc<Vec<BlogPost>>>,
    Path(slug): Path<String>,
) -> Result<Html<String>, StatusCode> {
    render_blog_article(posts.as_slice(), &slug)
}

async fn robots() -> Response {
    text_response("text/plain; charset=utf-8", robots_txt_content())
}

async fn sitemap(State(posts): State<Arc<Vec<BlogPost>>>) -> Response {
    text_response(
        "application/xml; charset=utf-8",
        sitemap_xml(posts.as_slice()),
    )
}

async fn llms(State(posts): State<Arc<Vec<BlogPost>>>) -> Response {
    text_response("text/plain; charset=utf-8", llms_txt(posts.as_slice()))
}

async fn llms_full(State(posts): State<Arc<Vec<BlogPost>>>) -> Response {
    text_response("text/plain; charset=utf-8", llms_full_txt(posts.as_slice()))
}

async fn feed(State(posts): State<Arc<Vec<BlogPost>>>) -> Response {
    text_response(
        "application/atom+xml; charset=utf-8",
        feed_xml(posts.as_slice()),
    )
}

async fn feed_json_endpoint(State(posts): State<Arc<Vec<BlogPost>>>) -> Response {
    json_response(&feed_json(posts.as_slice()))
}

async fn api_posts(State(posts): State<Arc<Vec<BlogPost>>>) -> Response {
    json_response(&api_posts_json(posts.as_slice()))
}

async fn api_projects() -> Response {
    let projects = load_projects();
    json_response(&api_projects_json(&projects))
}

async fn api_profile() -> Response {
    json_response(&api_profile_json())
}

async fn agent_manifest() -> Response {
    json_response(&agent_manifest_json())
}

async fn openapi() -> Response {
    json_response(&openapi_json())
}

async fn api_post(
    State(posts): State<Arc<Vec<BlogPost>>>,
    Path(path): Path<String>,
) -> Result<Response, StatusCode> {
    let slug = path.strip_suffix(".json").unwrap_or(&path);
    let post = posts
        .iter()
        .find(|post| post.slug == slug)
        .ok_or(StatusCode::NOT_FOUND)?;
    Ok(json_response(&api_post_json(post)))
}

async fn legacy_home(Path(_id): Path<u8>) -> Redirect {
    Redirect::permanent("/")
}

async fn legacy_page(Path((_id, page)): Path<(u8, String)>) -> Redirect {
    let target = match page.as_str() {
        "blog" => "/blog/",
        "projects" => "/projects/",
        "resume" => "/resume/",
        _ => "/",
    };
    Redirect::permanent(target)
}

fn legacy_blog_target(slug: &str) -> String {
    match slug {
        "fe621-finite-difference-sketches" => {
            "/blog/computational-methods-finite-difference-sketches/".to_owned()
        }
        "fe621-midterm-cheat-sheet" => {
            "/blog/computational-methods-midterm-cheat-sheet/".to_owned()
        }
        _ => {
            if let Some(week) = slug
                .strip_prefix("fe621-week-")
                .and_then(|week| week.parse::<u8>().ok())
                .filter(|week| (1..=14).contains(week) && *week != 8)
            {
                return format!("/blog/computational-methods-week-{week:02}/");
            }
            if let Some(week) = slug
                .strip_prefix("fe680-week-")
                .and_then(|week| week.parse::<u8>().ok())
                .filter(|week| (1..=13).contains(week))
            {
                return format!("/blog/advanced-derivatives-week-{week:02}/");
            }
            format!("/blog/{slug}/")
        }
    }
}

async fn legacy_blog_article(Path(slug): Path<String>) -> Redirect {
    let target = legacy_blog_target(&slug);
    Redirect::permanent(&target)
}

#[tokio::main]
async fn main() {
    let mut args = std::env::args().skip(1);
    match args.next().as_deref() {
        Some("--export-static") => {
            if let Some(argument) = args.next() {
                panic!("Unexpected argument after --export-static: {argument}");
            }
            let posts = load_blog_posts().expect("Could not load blog content");
            static_export::write_site(posts.as_slice(), FilePath::new("dist"))
                .expect("Could not export static site");
            println!(
                "Exported {} blog articles and site pages to dist/",
                posts.len()
            );
            return;
        }
        Some(argument) => panic!("Unknown argument: {argument}"),
        None => {}
    }

    let posts = Arc::new(load_blog_posts().expect("Could not load blog content"));
    let app = Router::new()
        .route("/", get(home))
        .route("/blog", get(blog_index))
        .route("/blog/", get(blog_index))
        .route("/blog/{slug}", get(blog_article))
        .route("/blog/{slug}/", get(blog_article))
        .route("/projects", get(projects))
        .route("/projects/", get(projects))
        .route("/resume", get(resume))
        .route("/resume/", get(resume))
        .route("/robots.txt", get(robots))
        .route("/sitemap.xml", get(sitemap))
        .route("/llms.txt", get(llms))
        .route("/llms-full.txt", get(llms_full))
        .route("/feed.xml", get(feed))
        .route("/feed.json", get(feed_json_endpoint))
        .route("/api/posts.json", get(api_posts))
        .route("/api/posts/{*path}", get(api_post))
        .route("/api/projects.json", get(api_projects))
        .route("/api/profile.json", get(api_profile))
        .route("/api/openapi.json", get(openapi))
        .route("/.well-known/agent.json", get(agent_manifest))
        .route("/v/6/blog/{slug}", get(legacy_blog_article))
        .route("/v/{id}/{page}", get(legacy_page))
        .route("/v/{id}", get(legacy_home))
        .route("/designs", get(|| async { Redirect::permanent("/") }))
        .nest_service("/static", ServeDir::new("static"))
        .with_state(posts);
    let address = std::env::var("PORTFOLIA_BIND").unwrap_or_else(|_| "127.0.0.1:8095".into());
    let listener = tokio::net::TcpListener::bind(&address)
        .await
        .expect("Could not bind preview address");
    println!("Portfolia: http://{address}/");
    axum::serve(listener, app)
        .await
        .expect("Could not serve application");
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn markdown_preserves_math_syntax_without_parsing_math_in_code() {
        let display_math = r"$$x\_i + \\frac{1}{2}$$";
        let inline_code_content = r"\(code_i\)";
        let tick = char::from(0x60);
        let inline_code = format!("{tick}{inline_code_content}{tick}");
        let fence = char::from(0x60).to_string().repeat(3);
        let fenced_code = format!("{fence}text\n$$code_j$$\n{fence}");
        let source = format!(
            "Inline \\(x_i < x_j\\).\n\n{display_math}\n\n{inline_code}\n\n{fenced_code}\n"
        );

        let html = render_markdown(&source);

        assert!(html.contains("Inline \\(x_i &lt; x_j\\)"));
        assert!(html.contains("$$x_i + \\frac{1}{2}$$"));
        assert!(html.contains(&format!("<code>{inline_code_content}</code>")));
        assert!(html.contains("$$code_j$$"));
        assert!(!html.contains("<em>"));
    }

    #[test]
    fn canonical_urls_and_legacy_article_aliases_are_stable() {
        assert_eq!(site_url("/"), "https://sharifhsn.dev/");
        assert_eq!(site_url("/blog"), "https://sharifhsn.dev/blog/");
        assert_eq!(
            site_url("/blog/circuits"),
            "https://sharifhsn.dev/blog/circuits/"
        );
        assert_eq!(
            site_url("/api/posts/circuits.json"),
            "https://sharifhsn.dev/api/posts/circuits.json"
        );
        assert_eq!(
            legacy_blog_target("fe621-week-02"),
            "/blog/computational-methods-week-02/"
        );
        assert_eq!(
            legacy_blog_target("fe680-week-01"),
            "/blog/advanced-derivatives-week-01/"
        );
        assert_eq!(legacy_blog_target("fe621-week-08"), "/blog/fe621-week-08/");
    }

    #[test]
    fn canonical_pages_render_with_metadata_and_real_assets() {
        for page in ["home", "projects", "resume"] {
            let Html(html) = render_site(page).unwrap();
            assert!(html.contains("Sharif Haason"), "page {page}");
            assert!(html.contains("https://schema.org"));
            assert!(html.contains("<link rel=\"canonical\""));
            assert!(!html.contains("/v/6"));
            assert!(!html.contains("/designs"));
            assert!(html.contains("/blog"));
            assert!(html.contains("/projects"));
            assert!(html.contains("/resume"));
            if page == "resume" {
                assert!(html.contains("Monark Markets"));
                assert!(html.contains("/static/resume/sharif-haason.pdf"));
                assert!(html.contains("/static/resume/sharif-haason.docx"));
            }
        }
        let Html(projects) = render_site("projects").unwrap();
        assert!(projects.contains("Implied Willow Tree for Derivatives"));
        assert!(projects.contains("application/ld+json"));
        assert!(projects.contains("project-nba-reddit-ai-chatbot"));
        assert_eq!(render_site("blog").unwrap_err(), StatusCode::NOT_FOUND);
        assert_eq!(render_site("missing").unwrap_err(), StatusCode::NOT_FOUND);
    }

    #[test]
    fn machine_readable_endpoints_cover_the_canonical_site() {
        let posts = load_blog_posts().unwrap();
        assert!(posts.iter().all(|post| !post.description.trim().is_empty()));
        let sitemap = sitemap_xml(&posts);
        assert_eq!(sitemap.matches("<url>").count(), posts.len() + 4);
        assert!(sitemap.contains("https://sharifhsn.dev/blog/circuits/"));

        let llms = llms_txt(&posts);
        assert!(llms.starts_with("# Sharif Haason"));
        assert!(llms.contains("[Writing index](https://sharifhsn.dev/blog/):"));
        assert!(llms.contains("[Structured writing index](https://sharifhsn.dev/api/posts.json):"));
        assert!(llms.contains("[Structured projects](https://sharifhsn.dev/api/projects.json):"));
        assert!(llms.contains("[Structured profile](https://sharifhsn.dev/api/profile.json):"));
        assert!(llms.contains("[Agent manifest](https://sharifhsn.dev/.well-known/agent.json):"));
        assert!(llms.contains("[OpenAPI description](https://sharifhsn.dev/api/openapi.json):"));
        assert!(llms.contains("[Full writing corpus](https://sharifhsn.dev/llms-full.txt):"));
        assert!(llms.contains("[Circuits](https://sharifhsn.dev/blog/circuits/):"));

        let full = llms_full_txt(&posts);
        assert!(full.starts_with("# Sharif Haason — full writing corpus"));
        assert!(full.contains("## Circuits"));
        assert!(full.contains("https://sharifhsn.dev/api/posts/circuits.json"));
        assert!(full.contains("Ohm's Law"));

        let feed = feed_xml(&posts);
        assert!(feed.contains("<feed xmlns=\"http://www.w3.org/2005/Atom\">"));
        assert_eq!(feed.matches("<entry>").count(), posts.len());
        assert!(feed.contains(&format!(
            "<updated>{}</updated>",
            atom_timestamp(posts[0].published_at.as_deref().unwrap_or(&posts[0].date))
        )));
        assert!(robots_txt_content().contains("Allow: /"));

        let feed_json = feed_json(&posts);
        assert_eq!(feed_json["version"], "https://jsonfeed.org/version/1.1");
        assert_eq!(feed_json["items"].as_array().unwrap().len(), posts.len());

        let index_json = api_posts_json(&posts);
        assert_eq!(index_json["version"], "1");
        assert_eq!(index_json["count"], posts.len());
        assert_eq!(index_json["items"].as_array().unwrap().len(), posts.len());
        let urls = index_json["items"]
            .as_array()
            .unwrap()
            .iter()
            .map(|item| item["url"].as_str().unwrap())
            .collect::<BTreeSet<_>>();
        assert_eq!(urls.len(), posts.len());
        for post in &posts {
            let url = site_url(&format!("/blog/{}", post.slug));
            assert!(llms.contains(&format!("({url}):")));
            assert!(full.contains(&format!("- URL: {url}")));
            assert!(feed.contains(&format!("<id>{url}</id>")));
        }
        assert!(!full.contains("Academics calendar"));

        let circuits = posts.iter().find(|post| post.slug == "circuits").unwrap();
        let article_json = api_post_json(circuits);
        assert_eq!(article_json["slug"], "circuits");
        assert!(
            article_json["contentMarkdown"]
                .as_str()
                .unwrap()
                .contains("Ohm's Law")
        );
        assert!(
            article_json["contentHtml"]
                .as_str()
                .unwrap()
                .contains("Electromotive Force")
        );

        let projects = load_projects();
        assert_eq!(projects.len(), 5);
        assert!(
            projects
                .iter()
                .any(|project| project.slug == "nba-reddit-ai-chatbot")
        );
        let projects_json = api_projects_json(&projects);
        assert_eq!(projects_json["count"], projects.len());
        assert!(
            projects_json["items"][0]["url"]
                .as_str()
                .unwrap()
                .starts_with("https://sharifhsn.dev/projects/#project-")
        );
        let profile_json = api_profile_json();
        assert_eq!(profile_json["person"]["name"], SITE_NAME);
        assert_eq!(
            profile_json["resume"]["pdfUrl"],
            "https://sharifhsn.dev/static/resume/sharif-haason.pdf"
        );
        let manifest = agent_manifest_json();
        assert_eq!(manifest["access"], "public-read-only");
        assert_eq!(manifest["mutations"], false);
        assert!(
            manifest["discovery"]
                .as_array()
                .unwrap()
                .iter()
                .any(|item| {
                    item["rel"] == "openapi"
                        && item["url"] == "https://sharifhsn.dev/api/openapi.json"
                })
        );
        let openapi = openapi_json();
        assert_eq!(openapi["openapi"], "3.1.0");
        assert!(openapi["paths"]["/api/posts/{slug}.json"].is_object());
        assert!(openapi["components"]["schemas"]["Post"].is_object());
    }

    #[test]
    fn all_migrated_posts_load_with_metadata_and_clean_markdown() {
        let posts = load_blog_posts().unwrap();
        assert_eq!(posts.len(), 153);
        assert_eq!(
            posts
                .iter()
                .filter(|post| post.source == "LinkedIn")
                .count(),
            35
        );
        assert_eq!(
            posts.iter().filter(|post| post.source == "Archive").count(),
            47
        );
        assert_eq!(
            posts
                .iter()
                .filter(|post| post.tags.contains(&"Computational Methods".to_owned()))
                .count(),
            15
        );
        assert_eq!(
            posts
                .iter()
                .filter(|post| post.tags.contains(&"Fixed Income".to_owned()))
                .count(),
            8
        );
        assert_eq!(
            posts
                .iter()
                .filter(|post| post.tags.contains(&"Credit".to_owned()))
                .count(),
            6
        );
        assert_eq!(
            posts
                .iter()
                .filter(|post| post.source == "FE-540 | Probability Theory")
                .count(),
            9
        );
        assert_eq!(
            posts
                .iter()
                .filter(|post| post.source == "FE-610 | Stochastic Calculus")
                .count(),
            13
        );
        assert_eq!(
            posts
                .iter()
                .filter(|post| post.source == "FE-535 | Risk Management")
                .count(),
            13
        );
        assert_eq!(
            posts
                .iter()
                .filter(|post| post.source == "FE-635 | Risk Engineering")
                .count(),
            8
        );
        assert!(
            posts
                .iter()
                .filter(|post| post.source == "FE-540 | Probability Theory")
                .all(|post| post.tags.contains(&"Probability Theory".to_owned()))
        );
        assert!(
            posts
                .iter()
                .filter(|post| post.source == "FE-610 | Stochastic Calculus")
                .all(|post| post.tags.contains(&"Stochastic Calculus".to_owned()))
        );
        assert!(
            posts
                .iter()
                .filter(|post| post.source == "FE-535 | Risk Management")
                .all(|post| post.tags.contains(&"Risk Management".to_owned()))
        );
        assert!(
            posts
                .iter()
                .filter(|post| post.source == "FE-635 | Risk Engineering")
                .all(|post| post.tags.contains(&"FX".to_owned()))
        );
        assert!(
            posts
                .iter()
                .filter(|post| post.source == "Computational Methods in Quantitative Finance")
                .all(|post| {
                    !post.tags.iter().any(|tag| {
                        [
                            "Probability Theory",
                            "Stochastic Calculus",
                            "Risk Management",
                        ]
                        .contains(&tag.as_str())
                    })
                })
        );
        assert!(
            posts
                .iter()
                .filter(|post| post.source == "Advanced Derivatives")
                .all(|post| {
                    !post
                        .tags
                        .iter()
                        .any(|tag| ["FX", "Risk Management"].contains(&tag.as_str()))
                })
        );
        assert!(
            posts
                .iter()
                .any(|post| post.slug == "computational-methods-week-14")
        );
        assert!(
            !posts
                .iter()
                .any(|post| post.slug == "computational-methods-week-08")
        );
        assert!(
            posts
                .iter()
                .any(|post| post.slug == "advanced-derivatives-week-12")
        );
        assert!(
            !posts
                .iter()
                .any(|post| post.slug == "advanced-derivatives-week-14")
        );
        assert!(posts.iter().all(|post| {
            !post.slug.contains("fe621")
                && !post.slug.contains("fe680")
                && !post.title.contains("FE-621")
                && !post.title.contains("FE-680")
                && !post
                    .tags
                    .iter()
                    .any(|label| label.contains("FE-621") || label.contains("FE-680"))
                && !post.body_html.contains("FE-621")
                && !post.body_html.contains("FE-680")
        }));

        let circuits = posts.iter().find(|post| post.slug == "circuits").unwrap();
        assert_eq!(circuits.title, "Circuits");
        assert_eq!(circuits.tags, ["Physics"]);
        assert!(circuits.has_math);
        assert!(circuits.body_html.contains("Ohm's Law"));
        assert!(!circuits.body_html.contains("<!-- more -->"));

        let python = posts
            .iter()
            .find(|post| post.slug == "python-crash-course")
            .unwrap();
        assert!(python.body_html.contains("<pre><code>2 # 2"));

        let linkedin = posts
            .iter()
            .find(|post| post.title == "Why Federal Reserve Independence Matters")
            .unwrap();
        assert!(
            linkedin
                .source_url
                .starts_with("https://www.linkedin.com/feed/update/")
        );
        assert!(
            linkedin
                .body_html
                .contains("href=\"https://lnkd.in/gBQviQzy\"")
        );

        let housing = posts
            .iter()
            .find(|post| post.slug == "linkedin-2024-10-08-minneapolis-housing-and-zoning")
            .unwrap();
        assert_eq!(housing.date, "2024-10-08");
        assert!(housing.body_html.contains("Minneapolis 2040 Plan"));
        assert!(
            housing
                .source_url
                .starts_with("https://www.linkedin.com/posts/")
        );
        let rust_post = posts
            .iter()
            .find(|post| post.slug == "linkedin-2024-09-23-rust-mir-to-dotnet")
            .unwrap();
        assert!(rust_post.tags.contains(&"Rust".to_owned()));

        let fe621 = posts
            .iter()
            .find(|post| post.slug == "computational-methods-week-02")
            .unwrap();
        assert!(fe621.tags.contains(&"Computational Methods".to_owned()));
        assert!(fe621.has_math);

        let fe680 = posts
            .iter()
            .find(|post| post.slug == "advanced-derivatives-week-01")
            .unwrap();
        assert!(fe680.tags.contains(&"Fixed Income".to_owned()));
        assert!(!fe680.tags.contains(&"Advanced Derivatives".to_owned()));
        assert!(fe680.has_math);
        assert!(fe680.body_html.contains("DV01"));
        assert!(!posts.iter().any(|post| {
            post.slug == "ytm-and-the-yield-curve" || post.slug == "duration-and-dv01"
        }));
    }

    #[test]
    fn only_frequent_tags_are_shown_in_subject_groups() {
        let posts = load_blog_posts().unwrap();
        let groups = popular_tag_groups(&posts);
        assert_eq!(
            groups
                .iter()
                .map(|group| group.name.as_str())
                .collect::<Vec<_>>(),
            ["Quantitative Finance", "Computer Science", "Other"]
        );

        let visible_tags: Vec<&BlogTag> = groups.iter().flat_map(|group| &group.tags).collect();
        assert_eq!(visible_tags.len(), 12);
        assert!(visible_tags.iter().all(|tag| {
            tag.count >= MIN_VISIBLE_TAG_COUNT
                || REQUESTED_VISIBLE_TAGS.contains(&tag.name.as_str())
        }));
        assert_eq!(
            visible_tags
                .iter()
                .find(|tag| tag.name == "Rust")
                .unwrap()
                .count,
            8
        );
        assert!(!visible_tags.iter().any(|tag| tag.name == "AI"));
        assert!(posts.iter().all(|post| {
            post.display_tags
                .iter()
                .all(|tag| visible_tags.iter().any(|visible| visible.name == *tag))
        }));
    }

    #[test]
    fn blog_listing_and_article_render_all_content_links() {
        let posts = load_blog_posts().unwrap();
        let Html(index) = render_blog_index(&posts).unwrap();
        assert!(!index.contains("110 pieces, newest first"));
        assert!(index.contains("/blog/circuits"));
        assert!(index.contains("Default Fields in Rust Structs"));
        assert!(index.contains("Minneapolis Housing and Zoning"));
        assert!(index.contains("Bond Pricing, Duration, and DV01"));
        assert!(!index.contains("Advanced Derivatives: Week 1"));
        assert!(index.contains("Computational Methods"));
        assert!(!index.contains("Computational Methods in Quantitative Finance"));
        assert!(index.contains("data-tag-filter"));
        assert!(index.contains("id=\"writing-search\""));
        assert!(index.contains("data-search=\""));
        assert!(index.contains("class=\"post-description\""));
        assert!(index.contains("href=\"/api/posts.json\""));
        assert!(index.contains("type=\"radio\""));
        assert!(index.contains("name=\"writing-topic\""));
        assert!(!index.contains("<select"));
        assert!(index.contains("<h3>Quantitative Finance</h3>"));
        assert!(index.contains("<h3>Computer Science</h3>"));
        assert!(index.contains("<h3>Other</h3>"));
        assert!(index.contains("data-tag-select=\"Rust\""));
        assert!(!index.contains("value=\"AI\""));
        assert!(!index.contains("data-tag-select=\"AI\""));
        assert!(!index.contains("Course notes"));
        assert!(!index.contains("FE-621") && !index.contains("FE-680"));
        let methods_filter = index.find("value=\"Computational Methods\"").unwrap();
        let fixed_income_filter = index.find("value=\"Fixed Income\"").unwrap();
        assert!(
            methods_filter < fixed_income_filter,
            "tags inside a subject group should be alphabetized"
        );

        let Html(article) = render_blog_article(&posts, "circuits").unwrap();
        assert!(article.contains("Electromotive Force"));
        assert!(article.contains("/static/js/auto-render.min.js"));
        assert!(article.contains("https://sharifhsn.dev/blog/circuits/"));
        assert!(article.contains("Source: Archive"));
        assert!(article.contains("/api/posts/circuits.json"));
        assert!(article.contains("application/ld+json"));

        let Html(course_article) =
            render_blog_article(&posts, "computational-methods-week-02").unwrap();
        assert!(course_article.contains("Black–Scholes"));
        assert!(course_article.contains("Computational Methods"));
        assert!(!course_article.contains("FE-621") && !course_article.contains("FE-680"));
        assert_eq!(
            render_blog_article(&posts, "missing-slug").unwrap_err(),
            StatusCode::NOT_FOUND
        );
    }
}
