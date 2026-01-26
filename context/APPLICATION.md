# Application Structure and Functionality

This document describes the structure and functionality of the portfolio web application.

## Overview

The application is a multi-page personal portfolio website built with Rust. It displays resume information, including education, projects, experience, leadership, and skills, with each section on its own page. The application is built using the Axum web framework for the backend and Askama for templating.

## Backend (`src/main.rs`)

The backend is a single Rust file that defines the web server and data structures.

### Framework and Libraries

- **Axum**: A web application framework for building web services in Rust.
- **Askama**: A type-safe, compiled templating engine for Rust, used to render the HTML pages.
- **Tokio**: An asynchronous runtime for Rust.
- **Tower-http**: Provides HTTP-specific middleware, used here to serve static files.

### Data Structures

The application uses a set of nested structs to represent the resume data. The main struct is `Resume`, which contains all other information.

- `Resume`: The root data structure, containing the person's name, contact info, and lists of education, projects, experience, leadership, and skills.
- `ContactInfo`: Contains contact details like phone, email, LinkedIn, GitHub, and location.
- `Education`: Represents an educational institution attended, with details like degree, date, GPA, awards, and coursework.
- `Project`: Represents a project, with its name, technologies used, date, and a description.
- `Experience`: Represents a professional experience, with company, location, position, date, and a description.
- `Leadership`: Represents a leadership or extracurricular experience.
- `Skills`: Contains lists of technical skills and certifications.

All the data is stored in a single `resume.md` file in the `content` directory. The `get_resume_data()` function parses this file to populate the `Resume` struct.

### Routing

The application has the following routes:

- `GET /`: The main route that serves the home page. It calls the `index` handler.
- `GET /education`: Serves the education page. It calls the `education` handler.
- `GET /projects`: Serves the projects page. It calls the `projects` handler.
- `GET /experience`: Serves the experience page. It calls the `experience` handler.
- `GET /leadership`: Serves the leadership page. It calls the `leadership` handler.
- `GET /skills`: Serves the skills page. It calls the `skills` handler.
- `/static`: This route serves static files (CSS, images, etc.) from the `static` directory.

### Rendering

Each route has a corresponding handler function that is responsible for rendering the page. For example, the `education` handler function does the following:

1. Calls `get_resume_data()` to get the resume data.
2. Creates an instance of `EducationTemplate`, which is an Askama template pointing to `education.html`.
3. Renders the template with the resume data.
4. Returns the rendered HTML as the response.

This pattern is repeated for all other routes.

## Frontend (`templates/`)

The frontend is composed of HTML templates powered by the Askama engine.

### `base.html`

This is the base layout for all pages. It includes:

- The basic HTML structure (`<head>`, `<body>`).
- A link to the Tailwind CSS stylesheet (`/static/css/output.css`).
- A header with navigation links to the different pages of the site.
- A main content block (`{% block content %}{% endblock %}`) that other templates can override.
- A footer.

### Page Templates (`index.html`, `education.html`, etc.)

Each page of the site has its own template:

- `index.html`: The template for the home page. It extends `base.html` and includes a hero section with contact information and a brief welcome message.
- `education.html`: Renders the education history.
- `projects.html`: Renders the list of projects.
- `experience.html`: Renders the professional experience.
- `leadership.html`: Renders leadership and extracurricular experience.
- `skills.html`: Renders the skills and certifications.

Each of these page templates extends `base.html` and provides the content for the `content` block.

## How it Works

1. A user navigates to a URL, for example `/projects`.
2. The Axum router matches the `GET /projects` route and calls the `projects` handler.
3. The `projects` handler calls `get_resume_data()` to get the resume information, which is parsed from `content/resume.md`.
4. The handler then renders the `projects.html` template, passing the resume data to it.
5. `projects.html` extends `base.html` and renders the list of projects.
6. The final, fully rendered HTML is sent back to the user's browser.
7. The browser also requests the CSS file from `/static/css/output.css`, which is served by the `ServeDir` service.
