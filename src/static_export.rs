use axum::http::StatusCode;
use std::{fs, io, path::Path};

use super::{BlogPost, render_blog_article, render_blog_index, render_site};

pub(super) fn write_site(posts: &[BlogPost], output_dir: &Path) -> io::Result<()> {
    if output_dir.exists() {
        fs::remove_dir_all(output_dir)?;
    }
    fs::create_dir_all(output_dir)?;

    let home = render_site("home").map_err(render_status_error)?;
    write_route(output_dir, "", &home.0)?;

    let blog = render_blog_index(posts).map_err(render_status_error)?;
    write_route(output_dir, "blog", &blog.0)?;
    let projects = render_site("projects").map_err(render_status_error)?;
    write_route(output_dir, "projects", &projects.0)?;
    let resume = render_site("resume").map_err(render_status_error)?;
    write_route(output_dir, "resume", &resume.0)?;

    for post in posts {
        let html = render_blog_article(posts, &post.slug).map_err(render_status_error)?;
        write_route(output_dir, &format!("blog/{}", post.slug), &html.0)?;
    }

    fs::write(output_dir.join("robots.txt"), super::robots_txt_content())?;
    fs::write(output_dir.join("sitemap.xml"), super::sitemap_xml(posts))?;
    fs::write(output_dir.join("llms.txt"), super::llms_txt(posts))?;
    fs::write(output_dir.join("feed.xml"), super::feed_xml(posts))?;

    copy_directory(
        Path::new(env!("CARGO_MANIFEST_DIR"))
            .join("static")
            .as_path(),
        output_dir.join("static").as_path(),
    )?;

    let mut redirects = String::from(
        "/v/6 / 301\n/designs / 301\n/v/:id / 301\n/v/:id/blog /blog 301\n/v/:id/projects /projects 301\n/v/:id/resume /resume 301\n/v/6/blog/:slug /blog/:slug 301\n",
    );
    for week in 1..=14 {
        if week == 8 {
            continue;
        }
        redirects.push_str(&format!(
            "/v/6/blog/fe621-week-{week:02} /blog/computational-methods-week-{week:02} 301\n"
        ));
    }
    for week in 1..=13 {
        redirects.push_str(&format!(
            "/v/6/blog/fe680-week-{week:02} /blog/advanced-derivatives-week-{week:02} 301\n"
        ));
    }
    redirects.push_str(
        "/v/6/blog/fe621-finite-difference-sketches /blog/computational-methods-finite-difference-sketches 301\n",
    );
    redirects.push_str(
        "/v/6/blog/fe621-midterm-cheat-sheet /blog/computational-methods-midterm-cheat-sheet 301\n",
    );
    fs::write(output_dir.join("_redirects"), redirects)?;
    fs::write(
        output_dir.join("404.html"),
        r#"<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Page not found | Sharif Haason</title>
  <link rel="stylesheet" href="/static/css/site.css">
</head>
<body>
  <main class="content">
    <h1>Page not found</h1>
    <p>This page may have moved or no longer exists.</p>
    <p><a href="/">Go to the home page</a> or <a href="/blog">browse the writing</a>.</p>
  </main>
</body>
</html>
"#,
    )?;

    Ok(())
}

fn render_status_error(status: StatusCode) -> io::Error {
    io::Error::other(format!("could not render a site page: {status}"))
}

fn write_route(output_dir: &Path, route: &str, html: &str) -> io::Result<()> {
    let mut route_dir = output_dir.to_path_buf();
    for segment in route.split('/').filter(|segment| !segment.is_empty()) {
        if segment == "." || segment == ".." {
            return Err(io::Error::new(
                io::ErrorKind::InvalidInput,
                "route contains an invalid path segment",
            ));
        }
        route_dir.push(segment);
    }
    fs::create_dir_all(&route_dir)?;
    fs::write(route_dir.join("index.html"), html)
}

fn copy_directory(source: &Path, destination: &Path) -> io::Result<()> {
    fs::create_dir_all(destination)?;
    for entry in fs::read_dir(source)? {
        let entry = entry?;
        let destination_path = destination.join(entry.file_name());
        let file_type = entry.file_type()?;
        if file_type.is_dir() {
            copy_directory(&entry.path(), &destination_path)?;
        } else if file_type.is_file() {
            fs::copy(entry.path(), destination_path)?;
        } else {
            return Err(io::Error::other(format!(
                "unsupported static asset type at {}",
                entry.path().display()
            )));
        }
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::write_site;
    use std::{fs, time::SystemTime};

    #[test]
    fn export_contains_root_all_articles_and_pages_asset_files() {
        let posts = super::super::load_blog_posts().expect("blog content should load");
        let nonce = SystemTime::now()
            .duration_since(SystemTime::UNIX_EPOCH)
            .expect("clock should be after the epoch")
            .as_nanos();
        let output = std::env::temp_dir().join(format!("portfolia-pages-test-{nonce}"));

        write_site(&posts, &output).expect("static site should export");

        let home = fs::read_to_string(output.join("index.html")).expect("root page exists");
        assert!(home.contains("Sharif Haason"));
        assert!(output.join("blog/index.html").is_file());
        assert!(output.join("projects/index.html").is_file());
        assert!(output.join("resume/index.html").is_file());
        assert!(output.join("robots.txt").is_file());
        assert!(output.join("sitemap.xml").is_file());
        assert!(output.join("llms.txt").is_file());
        assert!(output.join("feed.xml").is_file());
        assert!(output.join("404.html").is_file());
        let redirects = fs::read_to_string(output.join("_redirects")).expect("redirects exist");
        assert!(
            redirects.contains("/v/6/blog/fe621-week-02 /blog/computational-methods-week-02 301")
        );
        assert!(
            redirects.contains("/v/6/blog/fe680-week-01 /blog/advanced-derivatives-week-01 301")
        );
        assert!(output.join("static/css/site.css").is_file());

        let blog_index =
            fs::read_to_string(output.join("blog/index.html")).expect("blog index exists");
        assert!(blog_index.contains(&format!("{} pieces", posts.len())));
        for post in &posts {
            assert!(
                output
                    .join("blog")
                    .join(&post.slug)
                    .join("index.html")
                    .is_file(),
                "missing exported article {}",
                post.slug
            );
        }

        fs::remove_dir_all(output).expect("temporary export should be removed");
    }
}
