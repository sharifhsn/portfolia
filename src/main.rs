use askama::Template;
use axum::{
    Router,
    http::StatusCode,
    response::{Html, IntoResponse, Response},
    routing::get,
};
use lazy_static::lazy_static;
use markdown::{
    mdast::{List, Node, Text},
    to_html_with_options, to_mdast,
};
use serde::Deserialize;
use std::collections::HashMap;
use std::fs;
use thiserror::Error;
use tower_http::services::ServeDir;

#[derive(Error, Debug)]
enum AppError {
    #[error("Failed to read resume file: {0}")]
    ResumeRead(#[from] std::io::Error),

    #[error("Failed to parse resume markdown: {0}")]
    ResumeParse(String),

    #[error("Failed to render template: {0}")]
    Template(#[from] askama::Error),
}

impl From<markdown::message::Message> for AppError {
    fn from(msg: markdown::message::Message) -> Self {
        AppError::ResumeParse(msg.to_string())
    }
}

impl IntoResponse for AppError {
    fn into_response(self) -> Response {
        let (status, error_message) = match self {
            AppError::ResumeRead(_) | AppError::ResumeParse(_) => (
                StatusCode::INTERNAL_SERVER_ERROR,
                "There was a problem loading server data.",
            ),
            AppError::Template(_) => (
                StatusCode::INTERNAL_SERVER_ERROR,
                "There was a problem rendering the page.",
            ),
        };

        (status, error_message).into_response()
    }
}

#[derive(Template)]
#[template(path = "index.html")]
struct IndexTemplate<'a> {
    resume: &'a Resume,
}

#[derive(Template)]
#[template(path = "education.html")]
struct EducationTemplate<'a> {
    resume: &'a Resume,
}

#[derive(Template)]
#[template(path = "projects.html")]
struct ProjectsTemplate<'a> {
    resume: &'a Resume,
}

#[derive(Template)]
#[template(path = "experience.html")]
struct ExperienceTemplate<'a> {
    resume: &'a Resume,
}

#[derive(Template)]
#[template(path = "leadership.html")]
struct LeadershipTemplate<'a> {
    resume: &'a Resume,
}

#[derive(Template)]
#[template(path = "skills.html")]
struct SkillsTemplate<'a> {
    resume: &'a Resume,
}

#[derive(Template)]
#[template(path = "resume.html")]
struct ResumeTemplate<'a> {
    resume: &'a Resume,
}

#[derive(Deserialize, Clone, Default, Debug)]
struct Resume {
    name: String,
    contact: ContactInfo,
    education: Vec<Education>,
    projects: Vec<Project>,
    experience: Vec<Experience>,
    leadership: Vec<Leadership>,
    skills: Skills,
}

#[derive(Deserialize, Clone, Default, Debug)]
struct ContactInfo {
    phone: String,
    email: String,
    linkedin: String,
    github: String,
    location: String,
}

#[derive(Deserialize, Clone, Default, Debug)]
struct Education {
    institution: String,
    location: String,
    degree: String,
    date: String,
    gpa: String,
    awards: String,
    coursework: String,
}

#[derive(Deserialize, Clone, Default, Debug)]
struct Project {
    name: String,
    technologies: String,
    date: String,
    description: String,
}

#[derive(Deserialize, Clone, Default, Debug)]
struct Experience {
    company: String,
    location: String,
    position: String,
    date: String,
    description: String,
    details: Option<String>,
}

#[derive(Deserialize, Clone, Default, Debug)]
struct Leadership {
    organization: String,
    location: String,
    position: String,
    date: String,
    description: String,
}

#[derive(Deserialize, Clone, Default, Debug)]
struct Skill {
    name: String,
    description: String,
}

#[derive(Deserialize, Clone, Default, Debug)]
struct Certification {
    name: String,
    description: String,
}

#[derive(Deserialize, Clone, Default, Debug)]
struct Skills {
    skills: Vec<Skill>,
    certifications: Vec<Certification>,
}

lazy_static! {
    static ref RESUME: Resume = parse_resume().expect("Failed to parse resume");
}

fn get_text_content(node: &Node) -> String {
    let mut content = String::new();
    if let Some(children) = node.children() {
        for child in children {
            if let Node::Text(text) = child {
                content.push_str(&text.value);
            } else if let Node::Link(link) = child {
                content.push_str(&get_text_content(&Node::Link(link.clone())));
            } else if let Node::Strong(strong) = child {
                content.push_str(&get_text_content(&Node::Strong(strong.clone())));
            }
        }
    }
    content
}

fn get_list_content_as_html(node: &Node) -> String {
    if let Some(position) = node.position() {
        let markdown = fs::read_to_string("content/resume.md").unwrap();
        let slice = &markdown[position.start.offset..position.end.offset];
        return to_html_with_options(slice, &markdown::Options::gfm()).unwrap_or_default();
    }
    "".to_string()
}

fn parse_key_value_list(list: &List) -> HashMap<String, Node> {
    let mut map = HashMap::new();
    for item_node in &list.children {
        if let Node::ListItem(item) = item_node
            && let Some(Node::Paragraph(p)) = item.children.first()
            && let Some(Node::Strong(s)) = p.children.first()
        {
            let key = get_text_content(&Node::Strong(s.clone()))
                .trim_end_matches(':')
                .to_string();

            if p.children.len() > 1 {
                if let Some(Node::Text(t)) = p.children.get(1) {
                    map.insert(
                        key,
                        Node::Text(Text {
                            value: t.value.trim().to_string(),
                            position: None,
                        }),
                    );
                }
            } else if let Some(Node::List(l)) = item.children.get(1) {
                map.insert(key, Node::List(l.clone()));
            }
        }
    }
    map
}

fn parse_resume() -> Result<Resume, AppError> {
    let markdown = fs::read_to_string("content/resume.md")?;
    let root = to_mdast(&markdown, &markdown::ParseOptions::default())?;
    let mut resume = Resume::default();

    if let Node::Root(root) = root {
        let mut children_iter = root.children.iter().peekable();

        if let Some(Node::Heading(h)) = children_iter.next()
            && h.depth == 1
        {
            resume.name = get_text_content(&Node::Heading(h.clone()));
        }

        if let Some(Node::List(list)) = children_iter.next() {
            for item in &list.children {
                if let Node::ListItem(li) = item
                    && let Some(Node::Paragraph(p)) = li.children.first()
                {
                    let text = get_text_content(&Node::Paragraph(p.clone()));
                    let parts: Vec<&str> = text.splitn(2, ':').collect();
                    if parts.len() == 2 {
                        let key = parts[0].trim().replace("**", "");
                        let value = parts[1].trim();
                        match key.as_str() {
                            "Phone" => resume.contact.phone = value.to_string(),
                            "Email" => resume.contact.email = value.to_string(),
                            "LinkedIn" => resume.contact.linkedin = value.to_string(),
                            "GitHub" => resume.contact.github = value.to_string(),
                            "Location" => resume.contact.location = value.to_string(),
                            _ => {}
                        }
                    }
                }
            }
        }

        let mut current_section_title = "";
        while let Some(node) = children_iter.next() {
            if let Node::Heading(h) = node {
                if h.depth == 1 {
                    current_section_title = get_text_content(&Node::Heading(h.clone()))
                        .trim()
                        .to_string()
                        .leak();
                } else if h.depth == 2 {
                    let item_title = get_text_content(&Node::Heading(h.clone()));

                    if let Some(&Node::List(list)) = children_iter.peek() {
                        let content_map = parse_key_value_list(list);

                        match current_section_title {
                            "Education" => {
                                let mut edu = Education {
                                    institution: item_title,
                                    ..Default::default()
                                };
                                if let Some(Node::Text(t)) = content_map.get("Location") {
                                    edu.location = t.value.clone();
                                }
                                if let Some(Node::Text(t)) = content_map.get("Degree") {
                                    edu.degree = t.value.clone();
                                }
                                if let Some(Node::Text(t)) = content_map.get("Date") {
                                    edu.date = t.value.clone();
                                }
                                if let Some(Node::Text(t)) = content_map.get("GPA") {
                                    edu.gpa = t.value.clone();
                                }
                                if let Some(Node::List(l)) = content_map.get("Awards") {
                                    edu.awards = get_list_content_as_html(&Node::List(l.clone()));
                                }
                                if let Some(Node::List(l)) = content_map.get("Relevant Coursework")
                                {
                                    edu.coursework =
                                        get_list_content_as_html(&Node::List(l.clone()));
                                }
                                resume.education.push(edu);
                            }
                            "Experience" => {
                                let mut exp = Experience {
                                    company: item_title,
                                    ..Default::default()
                                };
                                if let Some(Node::Text(t)) = content_map.get("Position") {
                                    exp.position = t.value.clone();
                                }
                                if let Some(Node::Text(t)) = content_map.get("Location") {
                                    exp.location = t.value.clone();
                                }
                                if let Some(Node::Text(t)) = content_map.get("Date") {
                                    exp.date = t.value.clone();
                                }
                                if let Some(Node::List(l)) = content_map.get("Description") {
                                    exp.description =
                                        get_list_content_as_html(&Node::List(l.clone()));
                                }
                                if let Some(Node::List(l)) = content_map.get("Details") {
                                    exp.details =
                                        Some(get_list_content_as_html(&Node::List(l.clone())));
                                }
                                resume.experience.push(exp);
                            }
                            "Projects" => {
                                let mut proj = Project {
                                    name: item_title,
                                    ..Default::default()
                                };
                                if let Some(Node::Text(t)) = content_map.get("Technologies") {
                                    proj.technologies = t.value.clone();
                                }
                                if let Some(Node::Text(t)) = content_map.get("Date") {
                                    proj.date = t.value.clone();
                                }
                                if let Some(Node::List(l)) = content_map.get("Description") {
                                    proj.description =
                                        get_list_content_as_html(&Node::List(l.clone()));
                                }
                                resume.projects.push(proj);
                            }
                            "Leadership" => {
                                let mut lead = Leadership {
                                    organization: item_title,
                                    ..Default::default()
                                };
                                if let Some(Node::Text(t)) = content_map.get("Position") {
                                    lead.position = t.value.clone();
                                }
                                if let Some(Node::Text(t)) = content_map.get("Location") {
                                    lead.location = t.value.clone();
                                }
                                if let Some(Node::Text(t)) = content_map.get("Date") {
                                    lead.date = t.value.clone();
                                }
                                if let Some(Node::List(l)) = content_map.get("Description") {
                                    lead.description =
                                        get_list_content_as_html(&Node::List(l.clone()));
                                }
                                resume.leadership.push(lead);
                            }
                            "Skills" => {
                                if let Some(Node::List(list)) = children_iter.next() {
                                    for item in &list.children {
                                        if let Node::ListItem(li) = item
                                            && let Some(Node::Paragraph(p)) = li.children.first()
                                        {
                                            let text =
                                                get_text_content(&Node::Paragraph(p.clone()));
                                            let parts: Vec<&str> = text.splitn(2, ':').collect();
                                            if parts.len() == 2 {
                                                let name =
                                                    parts[0].replace("**", "").trim().to_string();
                                                let description = parts[1].trim().to_string();
                                                if item_title == "Skills" {
                                                    resume
                                                        .skills
                                                        .skills
                                                        .push(Skill { name, description });
                                                } else if item_title == "Certifications" {
                                                    resume
                                                        .skills
                                                        .certifications
                                                        .push(Certification { name, description });
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            _ => {}
                        }
                    }
                }
            }
        }
    } else {
        return Err(AppError::ResumeParse("Root node not found".to_string()));
    }

    Ok(resume)
}

async fn index() -> Result<Html<String>, AppError> {
    Ok(Html(IndexTemplate { resume: &RESUME }.render()?))
}

async fn education() -> Result<Html<String>, AppError> {
    Ok(Html(EducationTemplate { resume: &RESUME }.render()?))
}

async fn projects() -> Result<Html<String>, AppError> {
    Ok(Html(ProjectsTemplate { resume: &RESUME }.render()?))
}

async fn experience() -> Result<Html<String>, AppError> {
    Ok(Html(ExperienceTemplate { resume: &RESUME }.render()?))
}

async fn leadership() -> Result<Html<String>, AppError> {
    Ok(Html(LeadershipTemplate { resume: &RESUME }.render()?))
}

async fn skills() -> Result<Html<String>, AppError> {
    Ok(Html(SkillsTemplate { resume: &RESUME }.render()?))
}

async fn resume() -> Result<Html<String>, AppError> {
    Ok(Html(ResumeTemplate { resume: &RESUME }.render()?))
}

#[shuttle_runtime::main]
async fn main() -> shuttle_axum::ShuttleAxum {
    let router = Router::new()
        .route("/", get(index))
        .route("/education", get(education))
        .route("/projects", get(projects))
        .route("/experience", get(experience))
        .route("/leadership", get(leadership))
        .route("/skills", get(skills))
        .route("/resume", get(resume))
        .nest_service("/static", ServeDir::new("static"));

    Ok(router.into())
}
