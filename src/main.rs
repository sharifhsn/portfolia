mod static_export;

use askama::Template;
use axum::{
    Router,
    extract::{Path, State},
    http::StatusCode,
    response::{Html, Redirect},
    routing::get,
};
use std::{
    collections::{BTreeMap, BTreeSet},
    fs,
    path::Path as FilePath,
    sync::Arc,
};
use toml::Value as TomlValue;
use tower_http::services::ServeDir;

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

macro_rules! design {
    ($name:ident, $file:literal) => {
        #[derive(Template)]
        #[template(path = $file)]
        struct $name<'a> {
            page: &'a str,
            resume_html: &'a str,
            pdf_available: bool,
            docx_available: bool,
            photo_available: bool,
        }
    };
}
design!(Variant1, "variant1.html");
design!(Variant2, "variant2.html");
design!(Variant3, "variant3.html");
design!(Variant4, "variant4.html");
design!(Variant5, "variant5.html");
design!(Variant6, "variant6.html");

#[derive(Template)]
#[template(path = "designs.html")]
struct Designs;

#[derive(Clone)]
struct BlogPost {
    slug: String,
    title: String,
    date: String,
    date_display: String,
    description: String,
    tags: Vec<String>,
    display_tags: Vec<String>,
    tag_keys: String,
    search_text: String,
    source: String,
    source_url: String,
    body_html: String,
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

#[derive(Template)]
#[template(path = "blog.html")]
struct BlogIndex<'a> {
    posts: &'a [BlogPost],
    total: usize,
    tag_groups: &'a [BlogTagGroup],
}

#[derive(Template)]
#[template(path = "article.html")]
struct BlogArticle<'a> {
    post: &'a BlogPost,
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
            let mut run = 1;
            while characters.peek() == Some(&'\\') {
                characters.next();
                run += 1;
            }
            normalized.push_str(&"\\".repeat((run + 1) / 2));
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
        let description = metadata
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
        let body_html = render_markdown(&body);
        let has_math = body.contains("$$") || body.contains("\\(") || body.contains("\\[");
        let sort_key = metadata
            .get("published_at")
            .and_then(TomlValue::as_str)
            .unwrap_or(&date)
            .to_owned();
        let date_display = date.chars().take(10).collect();
        let tag_keys = tags.join("|");
        let search_text = format!("{} {} {}", title, description, tags.join(" "));
        posts.push(BlogPost {
            slug,
            title,
            date,
            date_display,
            description,
            tags,
            display_tags: Vec::new(),
            tag_keys,
            search_text,
            source: source_name,
            source_url,
            body_html,
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

    BlogIndex {
        posts,
        total: posts.len(),
        tag_groups: &tag_groups,
    }
    .render()
    .map(Html)
    .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)
}

fn render_blog_article(posts: &[BlogPost], slug: &str) -> Result<Html<String>, StatusCode> {
    let post = posts
        .iter()
        .find(|post| post.slug == slug)
        .ok_or(StatusCode::NOT_FOUND)?;
    BlogArticle { post }
        .render()
        .map(Html)
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)
}

fn render_design(id: u8, page: &str) -> Result<Html<String>, StatusCode> {
    if !(1..=6).contains(&id) || !["home", "blog", "projects", "resume"].contains(&page) {
        return Err(StatusCode::NOT_FOUND);
    }
    let resume_html = markdown::to_html(include_str!("../content/resume-current.md"));
    macro_rules! render {
        ($name:ident) => {
            $name {
                page,
                resume_html: &resume_html,
                pdf_available: FilePath::new("static/resume/sharif-haason.pdf").is_file(),
                docx_available: FilePath::new("static/resume/sharif-haason.docx").is_file(),
                photo_available: FilePath::new("static/img/profile.jpg").is_file(),
            }
            .render()
        };
    }
    let html = match id {
        1 => render!(Variant1),
        2 => render!(Variant2),
        3 => render!(Variant3),
        4 => render!(Variant4),
        5 => render!(Variant5),
        6 => render!(Variant6),
        _ => unreachable!(),
    }
    .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;
    Ok(Html(html))
}

async fn home(Path(id): Path<u8>) -> Result<Html<String>, StatusCode> {
    render_design(id, "home")
}
async fn page(
    State(posts): State<Arc<Vec<BlogPost>>>,
    Path((id, page)): Path<(u8, String)>,
) -> Result<Html<String>, StatusCode> {
    if id == 6 && page == "blog" {
        return render_blog_index(posts.as_slice());
    }
    render_design(id, &page)
}
async fn blog_article(
    State(posts): State<Arc<Vec<BlogPost>>>,
    Path(slug): Path<String>,
) -> Result<Html<String>, StatusCode> {
    render_blog_article(posts.as_slice(), &slug)
}
async fn designs() -> Result<Html<String>, StatusCode> {
    Designs
        .render()
        .map(Html)
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)
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
        .route("/", get(|| async { Redirect::temporary("/v/6") }))
        .route("/designs", get(designs))
        .route("/v/{id}", get(home))
        .route("/v/6/blog/{slug}", get(blog_article))
        .route("/v/{id}/{page}", get(page))
        .route("/blog", get(|| async { Redirect::temporary("/v/6/blog") }))
        .route(
            "/projects",
            get(|| async { Redirect::temporary("/v/6/projects") }),
        )
        .route(
            "/resume",
            get(|| async { Redirect::temporary("/v/6/resume") }),
        )
        .nest_service("/static", ServeDir::new("static"))
        .with_state(posts);
    let address = std::env::var("PORTFOLIA_BIND").unwrap_or_else(|_| "127.0.0.1:8095".into());
    let listener = tokio::net::TcpListener::bind(&address)
        .await
        .expect("Could not bind preview address");
    println!("Portfolia design studies: http://{address}/designs");
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
    fn all_design_pages_render_with_real_assets() {
        for id in 1..=6 {
            for page in ["home", "blog", "projects", "resume"] {
                let Html(html) = render_design(id, page).unwrap();
                assert!(html.contains("Sharif"), "design {id}/{page}");
                assert!(html.contains(&format!("/v/{id}/blog")));
                assert!(html.contains(&format!("/v/{id}/projects")));
                assert!(html.contains(&format!("/v/{id}/resume")));
                if page == "resume" {
                    assert!(html.contains("Monark Markets"));
                    assert!(html.contains("/static/resume/sharif-haason.pdf"));
                    assert!(html.contains("/static/resume/sharif-haason.docx"));
                }
            }
        }
    }
    #[test]
    fn unknown_variants_and_pages_are_not_found() {
        assert_eq!(render_design(0, "home").unwrap_err(), StatusCode::NOT_FOUND);
        assert_eq!(render_design(7, "home").unwrap_err(), StatusCode::NOT_FOUND);
        assert_eq!(
            render_design(1, "missing").unwrap_err(),
            StatusCode::NOT_FOUND
        );
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
        assert!(index.contains("/v/6/blog/circuits"));
        assert!(index.contains("Default Fields in Rust Structs"));
        assert!(index.contains("Minneapolis Housing and Zoning"));
        assert!(index.contains("Bond Pricing, Duration, and DV01"));
        assert!(!index.contains("Advanced Derivatives: Week 1"));
        assert!(index.contains("Computational Methods"));
        assert!(!index.contains("Computational Methods in Quantitative Finance"));
        assert!(index.contains("data-tag-filter"));
        assert!(index.contains("id=\"writing-search\""));
        assert!(index.contains("data-search=\""));
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
