use axum::{
    routing::get,
    Router,
    response::{Html, IntoResponse, Response},
    http::StatusCode,
};
use askama::Template;
use tower_http::services::ServeDir;
use serde::Deserialize;
use thiserror::Error;

#[derive(Error, Debug)]
enum AppError {
    #[error("Failed to read resume file: {0}")]
    ResumeRead(#[from] std::io::Error),

    #[error("Failed to parse resume TOML: {0}")]
    ResumeParse(#[from] toml::de::Error),

    #[error("Failed to render template: {0}")]
    Template(#[from] askama::Error),
}

impl IntoResponse for AppError {
    fn into_response(self) -> Response {
        let (status, error_message) = match self {
            AppError::ResumeRead(_) | AppError::ResumeParse(_) => {
                (StatusCode::INTERNAL_SERVER_ERROR, "There was a problem loading server data.")
            }
            AppError::Template(_) => {
                (StatusCode::INTERNAL_SERVER_ERROR, "There was a problem rendering the page.")
            }
        };

        (status, error_message).into_response()
    }
}

#[derive(Template)]
#[template(path = "index.html")]
struct IndexTemplate {
    resume: Resume,
}

#[derive(Template)]
#[template(path = "education.html")]
struct EducationTemplate {
    resume: Resume,
}

#[derive(Template)]
#[template(path = "projects.html")]
struct ProjectsTemplate {
    resume: Resume,
}

#[derive(Template)]
#[template(path = "experience.html")]
struct ExperienceTemplate {
    resume: Resume,
}

#[derive(Template)]
#[template(path = "leadership.html")]
struct LeadershipTemplate {
    resume: Resume,
}

#[derive(Template)]
#[template(path = "skills.html")]
struct SkillsTemplate {
    resume: Resume,
}

#[derive(Template)]
#[template(path = "resume.html")]
struct ResumeTemplate {
    resume: Resume,
}

#[derive(Deserialize, Clone)]
struct Resume {
    name: String,
    contact: ContactInfo,
    education: Vec<Education>,
    projects: Vec<Project>,
    experience: Vec<Experience>,
    leadership: Vec<Leadership>,
    skills: Skills,
}

#[derive(Deserialize, Clone)]
struct ContactInfo {
    phone: String,
    email: String,
    linkedin: String,
    github: String,
    location: String,
}

#[derive(Deserialize, Clone)]
struct Education {
    institution: String,
    location: String,
    degree: String,
    date: String,
    gpa: String,
    awards: Vec<String>,
    coursework: Vec<String>,
}

#[derive(Deserialize, Clone)]
struct Project {
    name: String,
    technologies: String,
    date: String,
    description: Vec<String>,
}

#[derive(Deserialize, Clone)]
struct Experience {
    company: String,
    location: String,
    position: String,
    date: String,
    description: Vec<String>,
}

#[derive(Deserialize, Clone)]
struct Leadership {
    organization: String,
    location: String,
    position: String,
    date: String,
    description: Vec<String>,
}

#[derive(Deserialize, Clone)]
struct Skill {
    name: String,
    description: String,
}

#[derive(Deserialize, Clone)]
struct Certification {
    name: String,
    description: String,
}

#[derive(Deserialize, Clone)]
struct Skills {
    skills: Vec<Skill>,
    certifications: Vec<Certification>,
}

fn get_resume_data() -> Result<Resume, AppError> {
    let toml_str = std::fs::read_to_string("resume.toml")?;
    let resume = toml::from_str(&toml_str)?;
    Ok(resume)
}

async fn index() -> Result<Html<String>, AppError> {
    let resume = get_resume_data()?;
    Ok(Html(IndexTemplate { resume }.render()?))
}

async fn education() -> Result<Html<String>, AppError> {
    let resume = get_resume_data()?;
    Ok(Html(EducationTemplate { resume }.render()?))
}

async fn projects() -> Result<Html<String>, AppError> {
    let resume = get_resume_data()?;
    Ok(Html(ProjectsTemplate { resume }.render()?))
}

async fn experience() -> Result<Html<String>, AppError> {
    let resume = get_resume_data()?;
    Ok(Html(ExperienceTemplate { resume }.render()?))
}

async fn leadership() -> Result<Html<String>, AppError> {
    let resume = get_resume_data()?;
    Ok(Html(LeadershipTemplate { resume }.render()?))
}

async fn skills() -> Result<Html<String>, AppError> {
    let resume = get_resume_data()?;
    Ok(Html(SkillsTemplate { resume }.render()?))
}

async fn resume() -> Result<Html<String>, AppError> {
    let resume = get_resume_data()?;
    Ok(Html(ResumeTemplate { resume }.render()?))
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