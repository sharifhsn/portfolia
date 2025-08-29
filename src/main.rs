use axum::{
    routing::get,
    Router,
    response::Html,
};
use askama::Template;
use tower_http::services::ServeDir;

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

struct Resume {
    name: &'static str,
    contact: ContactInfo,
    education: Vec<Education>,
    projects: Vec<Project>,
    experience: Vec<Experience>,
    leadership: Vec<Leadership>,
    skills: Skills,
}

struct ContactInfo {
    phone: &'static str,
    email: &'static str,
    linkedin: &'static str,
    github: &'static str,
    location: &'static str,
}

struct Education {
    institution: &'static str,
    location: &'static str,
    degree: &'static str,
    date: &'static str,
    gpa: &'static str,
    awards: Vec<&'static str>,
    coursework: Vec<&'static str>,
}

struct Project {
    name: &'static str,
    technologies: &'static str,
    date: &'static str,
    description: Vec<&'static str>,
}

struct Experience {
    company: &'static str,
    location: &'static str,
    position: &'static str,
    date: &'static str,
    description: Vec<&'static str>,
}

struct Leadership {
    organization: &'static str,
    location: &'static str,
    position: &'static str,
    date: &'static str,
    description: Vec<&'static str>,
}

struct Skill {
    name: &'static str,
    description: &'static str,
}

struct Certification {
    name: &'static str,
    description: &'static str,
}

struct Skills {
    skills: Vec<Skill>,
    certifications: Vec<Certification>,
}

fn get_resume_data() -> Resume {
    Resume {
        name: "Sharif Haason",
        contact: ContactInfo {
            phone: "551-214-7115",
            email: "sharif.haason@gmail.com",
            linkedin: "linkedin.com/in/sharif-haason/",
            github: "github.com/sharifhsn/",
            location: "South River, NJ",
        },
        education: vec![
            Education {
                institution: "Stevens Institute of Technology, School of Business",
                location: "Hoboken, NJ",
                degree: "Master of Science, Financial Engineering",
                date: "Expected: Dec 2025",
                gpa: "GRE: 335/340",
                awards: vec!["Stevens Master’s Scholarship"],
                coursework: vec!["Interest Rate Derivatives", "Computational Methods", "Risk Management", "Pricing and Hedging", "Portfolio Theory"],
            },
            Education {
                institution: "Rutgers University, School of Arts and Sciences",
                location: "New Brunswick, NJ",
                degree: "Bachelor of Science, Computer Science",
                date: "Jan 2024",
                gpa: "SAT: 1580, ACT: 36",
                awards: vec!["Rutgers Honors College", "Trustee Scholarship", "National Merit Scholarship"],
                coursework: vec!["Data Science", "Linear Algebra", "Discrete Math", "Data Structures", "Design and Analysis of Algorithms", "Artificial Intelligence", "Computer Architecture", "Systems Programming", "Internet Technology"],
            },
        ],
        projects: vec![
            Project {
                name: "Master’s Thesis on Implied Willow Tree for Interest Rate Derivatives",
                technologies: "MATLAB, Research",
                date: "Jun 2025 - Present",
                description: vec![
                    "Dong et al. model the risk-neutral process by implying risk-neutral densities from market equity options and transitioning between nodes",
                    "In theory, any liquid options market could imply a willow tree for pricing path-dependent derivatives on the same risk-neutral process",
                    "My thesis work studies how this idea can be used to price exotic interest rate derivatives, taking ideas from HJM and credit markets",
                ],
            },
            Project {
                name: "High Frequency Trading Competition",
                technologies: "Python, SHIFT",
                date: "Mar 2025 - May 2025",
                description: vec![
                    "Won second place by implementing a market making strategy, using VWAP to predict market trends and adjusting size accordingly",
                    "Led the team and delegated tasks to my teammates, such as backtesting and research, and took notes during meetings for reference",
                    "Set up infrastructure on GitHub and acted as point of contact when IT issues arose related to a library bug with SHIFT and Fix Protocol",
                ],
            },
            Project {
                name: "Hornet Trading Contest",
                technologies: "Excel, VBA",
                date: "Feb 2025 - May 2025",
                description: vec![
                    "Participated in a trading contest with other students in Risk Engineering class for bonds, forwards, calls, and puts on USDMXN",
                    "Received request to quote from a client every week and decided what level to quote, winning or losing trade based on spread",
                    "Wrote VBA code to calculate Greeks for each type of instrument traded: Delta, Gamma, Rho for both USD and MXN, and Vega",
                    "Explained PnL of a trade using these risks, achieving low unexplained PnL, and used this information to verify hedging impact",
                    "Implemented strategies like risk reversal and delta hedging to reduce exposures to specific risks in order to conform to risk limits",
                    "Used macro information from current events on Bloomberg to correctly predict a falling dollar and adjust my exposure accordingly",
                ],
            },
            Project {
                name: "NBA Defensive Impact Analysis",
                technologies: "Python, Pandas",
                date: "Jul 2024 - Aug 2024",
                description: vec![
                    "Cleaned gigabytes of raw data from an API to remove unnecessary columns and changed their types to fit better in memory",
                    "Created backoff infrastructure to call from the API repeatedly and accumulate data without hitting rate limits while caching it",
                    "Researched well-known rim protectors and ran the analysis on them, comparing my statistic to an existing rim protection stat",
                    "Converted the final analysis from Pandas dataframes to SQL tables, synced to an MSSQL Server on Azure SQL for use with Power BI",
                ],
            },
            Project {
                name: "Hexyl - Terminal Hex Viewer",
                technologies: "Rust, GitHub",
                date: "Sept 2022 - Dec 2023",
                description: vec![
                    "Rewrote the architecture, optimizing squeezing identical lines, removing unnecessary formatting machinery, and caching operations",
                    "Improved performance by creating a flamegraph of application usage and profiling functions that represented a majority of slowness",
                    "Maintained the repository over a long period of time by answering issues and fixing bugs that arose from my new architecture",
                ],
            },
        ],
        experience: vec![
            Experience {
                company: "El Mashta LLC",
                location: "New York, NY",
                position: "DevOps Consultant",
                date: "Jun 2025 - Present",
                description: vec![
                    "Provisioned servers for general development workload, GPU inference, and GPU training, cutting $100/month in server costs",
                    "Set up development infrastructure to improve developer convenience, with robust declarative infrastructure as code through Terraform",
                    "Created and maintained organizational infrastructure for team communication and consistency in tool usage",
                ],
            },
            Experience {
                company: "Stevens Institute of Technology",
                location: "Hoboken, NJ",
                position: "Hanlon Financial Systems Team Lead",
                date: "Sept 2024 - Present",
                description: vec![
                    "Builds server infrastructure like virtual machines and software installation (Ray, vLLM) for distributed deep learning on H100 GPUs",
                    "Provides support for students and faculty using the lab during courses, resolving any technical issues as they arise",
                    "Assists in Hanlon Lab operations relating to hardware, software, and databases for professors in the finance departments",
                ],
            },
            Experience {
                company: "Cloudnosys, Inc",
                location: "Atlanta, GA",
                position: "DevSecOps Engineer",
                date: "Jun 2023 - Sept 2024",
                description: vec![
                    "Developed security control. methods in JavaScript with the AWS SDK API for an auditing service on AWS cloud accounts",
                    "Exposed OS vulnerabilities, misconfigurations, and malware, that contained alert metadata taken from AWS documentation on them",
                    "Managed an AWS cloud account for the purposes of debugging signatures and configured it in order to test security flaw detections",
                    "Added GCP security controls to bring our coverage more in line with AWS and attracted a client as a direct result of my work",
                ],
            },
            Experience {
                company: "Rutgers University",
                location: "Newark, NJ",
                position: "Application Developer Intern",
                date: "Jun 2021 - Jun 2023",
                description: vec![
                    "Developed an app to automate the submission and approval workflow of a form for course management using Power Apps",
                    "Integrated the app with the rest of the Office 365 ecosystem and eased use of the program for dozens of faculty members",
                    "Oversaw meetings demonstrating technology to clients, responding to requests for changes, and explaining technology to lay users",
                    "Used scripting languages such as Shell, Python, and PowerShell in order to automate SQL database accesses and program workflows",
                ],
            },
        ],
        leadership: vec![
            Leadership {
                organization: "Rutgers Book Club",
                location: "New Brunswick, NJ",
                position: "Treasurer",
                date: "Sept 2020 - May 2023",
                description: vec![
                    "Secured $800 in additional funding in a meeting with the Rutgers Student Assembly by demonstrating how our number of members and our savings on our arrangement with Barnes & Noble made us a good candidate for extra allocation after initial underfunding of $100",
                ],
            },
        ],
        skills: Skills {
            skills: vec![
                Skill { name: "Python", description: "A high-level, general-purpose programming language known for its readability and versatility in web development, data science, and automation." },
                Skill { name: "JavaScript", description: "A core web technology for creating interactive and dynamic content on websites, running on both client and server side." },
                Skill { name: "Git", description: "A distributed version control system for tracking changes in source code during software development, enabling collaboration and history management." },
                Skill { name: "Linux", description: "A family of open-source, Unix-like operating systems known for its stability, security, and flexibility, powering everything from servers to smartphones." },
                Skill { name: "Bash", description: "A command-line interpreter and scripting language for Unix-like systems, used for interacting with the operating system and automating tasks." },
                Skill { name: "SQL", description: "(Structured Query Language) A standard language for managing and manipulating data in relational databases." },
                Skill { name: "AWS", description: "(Amazon Web Services) A comprehensive cloud computing platform offering a wide range of services like computing power, storage, and databases." },
                Skill { name: "React", description: "An open-source JavaScript library for building user interfaces, particularly for single-page applications, using a component-based architecture." },
                Skill { name: "Rust", description: "A modern systems programming language focused on performance, memory safety, and concurrency, without needing a garbage collector." },
                Skill { name: "C++", description: "A high-performance, general-purpose language known for its object-oriented features and low-level memory manipulation capabilities." },
                Skill { name: "C", description: "A foundational, procedural programming language known for its efficiency and high degree of control over system hardware." },
                Skill { name: "LLMs", description: "(Large Language Models) A type of artificial intelligence trained on vast text data to understand and generate human-like language." },
                Skill { name: "Azure", description: "A cloud computing platform by Microsoft for building, deploying, and managing applications and services through a global network of data centers." },
                Skill { name: "Power Apps", description: "A low-code development platform by Microsoft for building custom web and mobile applications for business needs." },
                Skill { name: "Office 365", description: "A cloud-based subscription service from Microsoft that provides a suite of productivity and collaboration tools like Word, Excel, and Teams." },
                Skill { name: "Databricks", description: "A unified, cloud-based platform for data engineering, data science, and machine learning, built on Apache Spark." },
            ],
            certifications: vec![
                Certification { name: "AWS Solutions Architect", description: "Validates the ability to design and deploy secure, high-performing, and efficient cloud infrastructure on Amazon Web Services." },
                Certification { name: "AWS Developer", description: "Validates the ability to develop, deploy, and debug cloud-based applications using core AWS services and best practices." },
                Certification { name: "Azure Fundamentals", description: "Validates foundational knowledge of cloud concepts and Microsoft Azure services, pricing, and support." },
                Certification { name: "Databricks Data Engineer Associate", description: "Validates the ability to perform introductory data engineering tasks, including building ETL pipelines, using the Databricks platform." },
            ],
        },
    }
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
