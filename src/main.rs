use axum::{
    routing::get,
    Router,
    response::Html,
};
use askama::Template;
use tower_http::services::ServeDir;
use serde::Deserialize;

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

#[derive(Deserialize)]
struct Resume {
    name: String,
    contact: ContactInfo,
    education: Vec<Education>,
    projects: Vec<Project>,
    experience: Vec<Experience>,
    leadership: Vec<Leadership>,
    skills: Skills,
}

#[derive(Deserialize)]
struct ContactInfo {
    phone: String,
    email: String,
    linkedin: String,
    github: String,
    location: String,
}

#[derive(Deserialize)]
struct Education {
    institution: String,
    location: String,
    degree: String,
    date: String,
    gpa: String,
    awards: Vec<String>,
    coursework: Vec<String>,
}

#[derive(Deserialize)]
struct Project {
    name: String,
    technologies: String,
    date: String,
    description: Vec<String>,
}

#[derive(Deserialize)]
struct Experience {
    company: String,
    location: String,
    position: String,
    date: String,
    description: Vec<String>,
}

#[derive(Deserialize)]
struct Leadership {
    organization: String,
    location: String,
    position: String,
    date: String,
    description: Vec<String>,
}

#[derive(Deserialize)]
struct Skill {
    name: String,
    description: String,
}

#[derive(Deserialize)]
struct Certification {
    name: String,
    description: String,
}

#[derive(Deserialize)]
struct Skills {
    skills: Vec<Skill>,
    certifications: Vec<Certification>,
}

fn get_resume_data() -> Resume {
    let toml_str = std::fs::read_to_string("resume.toml").expect("Failed to read resume.toml");
    toml::from_str(&toml_str).expect("Failed to parse resume.toml")
}

async fn index() -> Html<String> {
    let resume = get_resume_data();
    Html(IndexTemplate { resume: &resume }.render().unwrap())
}

async fn education() -> Html<String> {
    let resume = get_resume_data();
    Html(EducationTemplate { resume: &resume }.render().unwrap())
}

async fn projects() -> Html<String> {
    let resume = get_resume_data();
    Html(ProjectsTemplate { resume: &resume }.render().unwrap())
}

async fn experience() -> Html<String> {
    let resume = get_resume_data();
    Html(ExperienceTemplate { resume: &resume }.render().unwrap())
}

async fn leadership() -> Html<String> {
    let resume = get_resume_data();
    Html(LeadershipTemplate { resume: &resume }.render().unwrap())
}

async fn skills() -> Html<String> {
    let resume = get_resume_data();
    Html(SkillsTemplate { resume: &resume }.render().unwrap())
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
        .nest_service("/static", ServeDir::new("static"));

    Ok(router.into())
}