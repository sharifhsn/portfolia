# Design Document

This document outlines the design philosophy and styling choices for the portfolio website.

## Overall Design Philosophy

The design aims to be clean, modern, and professional, with a touch of color to make it visually appealing. The focus is on readability and a clear presentation of the resume content. The layout is responsive and should work well on different screen sizes.

## Color Palette

The color palette is based on Tailwind CSS's default color scheme, with a focus on blues and grays for a professional look, and some accent colors to add visual interest.

- **Primary/Background:** The main background is a light `slate-200`, with a dark `slate-800` for the header and footer, creating a nice contrast.
- **Text:** The body text is a dark `slate-800`, while the text in the header and footer is `white`.
- **Headings:** Headings are a darker `slate-700` to stand out from the body text.
- **Links:** Links in the hero section are a bright `sky-400` to draw attention.
- **Skills & Certifications:** The skills and certifications are highlighted with `sky-200` and `emerald-200` backgrounds, respectively, with corresponding dark text colors.

## Typography

The website uses a sans-serif font stack provided by Tailwind CSS, which is clean and easy to read.

- **Headings:** Headings are bold and use a larger font size to create a clear hierarchy.
- **Body Text:** The body text is a standard size and weight for optimal readability.

## Layout

The website uses a single-page layout with a sticky navigation bar that allows users to easily jump to different sections of the page. The content is centered in a container with a maximum width to ensure readability on larger screens.

## Component Styling

- **Header & Footer:** The header and footer have a dark background (`slate-800`) and white text, which frames the content of the page.
- **Navigation Bar:** The navigation bar is part of the header and provides links to the different sections of the resume. The links have a hover effect to indicate interactivity.
- **Hero Section:** The hero section has a gradient background (`slate-700` to `slate-900`) to make it stand out. The text is white and the links are a bright blue.
- **Cards:** The content for education, projects, experience, and leadership is presented in cards with a white background and a subtle shadow. The cards have a hover effect that slowly fades their background to match the page's background color (`slate-200`), creating a soft 'sinking' visual effect.
- **Skills:** The skills and certifications are displayed as tags with a rounded shape and a light background color to make them easily scannable.

## Dark Mode

The dark mode uses a darker color palette to reduce eye strain in low-light environments. It is enabled automatically based on the user's system preferences.

- **Background:** The main background is `slate-900`.
- **Text:** Body text is `slate-300`, with headings being a lighter `slate-100`.
- **Header & Footer:** The header and footer remain `slate-800` but with slightly adjusted text colors for consistency.
- **Cards:** Cards use a `slate-800` background with `slate-300` text, and a hover effect to `slate-700`.
- **Hero Section:** The hero section gradient is adjusted to be from `slate-800` to `black`.
- **Skills & Certifications:** The tags use darker backgrounds (`sky-900` and `emerald-900`) with lighter text (`sky-200` and `emerald-200`).

## CSS Architecture and Workflow

The project utilizes the **Tailwind CSS** framework to build its visual design. This is a utility-first CSS framework that allows for rapid development by composing designs directly within the HTML files.

The workflow is as follows:

1.  **Styling in HTML**: Instead of writing separate CSS files, styles are applied by adding utility classes to HTML elements within the Askama templates (e.g., `<div class="bg-white p-6 rounded-lg shadow-lg">`).

2.  **Configuration**: The `tailwind.config.js` file configures the framework. It specifies which files to scan for class names in its `content` array (`./templates/**/*.html`, `./src/**/*.rs`). This allows Tailwind to remove unused styles and keep the final CSS file small.

3.  **Build Process**: The styling is not applied directly from the source files. A build step is required. The `Justfile` contains a `build-css` recipe which runs the command:
    '''bash
    tailwindcss -i ./static/css/input.css -o ./static/css/output.css
    '''
    This command takes the `input.css` file (which contains the core Tailwind directives `@tailwind base;`, `@tailwind components;`, `@tailwind utilities;`), scans the project files for classes, and generates a single, optimized stylesheet at `static/css/output.css`.

4.  **Serving CSS**: The final `output.css` file is the only stylesheet referenced by the application. It is linked in the `<head>` of the `templates/base.html` file and served as a static asset by the Axum web server.

**In summary, for any styling changes in the HTML templates to take effect, the `just build-css` command must be run before starting the server.** This ensures the `output.css` file is up-to-date with all the necessary styles.