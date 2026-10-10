use serde::Deserialize;
use std::sync::LazyLock;

pub(super) mod ldsc;
mod studies;

#[derive(Clone, Copy, Deserialize, PartialEq, Eq)]
#[serde(rename_all = "kebab-case")]
pub(super) enum Category {
    Numbers,
    Languages,
    Media,
    Tools,
    Knowledge,
}

impl Category {
    pub(super) fn key(self) -> &'static str {
        match self {
            Self::Numbers => "numbers",
            Self::Languages => "languages",
            Self::Media => "media",
            Self::Tools => "tools",
            Self::Knowledge => "knowledge",
        }
    }

    pub(super) fn label(self) -> &'static str {
        match self {
            Self::Numbers => "Numbers & models",
            Self::Languages => "Languages & compilers",
            Self::Media => "Pictures, games & sound",
            Self::Tools => "Small useful tools",
            Self::Knowledge => "Knowledge & local AI",
        }
    }
}

#[derive(Deserialize, PartialEq, Eq)]
#[serde(rename_all = "kebab-case")]
enum Status {
    Available,
    Study,
    Recorded,
    Planned,
}

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
pub(super) struct Experiment {
    pub(super) slug: String,
    pub(super) name: String,
    pub(super) category: Category,
    status: Status,
    pub(super) summary: String,
    pub(super) interest: String,
    pub(super) progress: String,
    pub(super) question: String,
    pub(super) scope: String,
    pub(super) demo_plan: String,
    pub(super) next_step: String,
    pub(super) rust_plan: String,
    pub(super) credit: String,
    pub(super) demo_href: Option<String>,
    #[serde(skip)]
    pub(super) preview_svg: String,
    #[serde(skip)]
    pub(super) preview_is_example: bool,
}

impl Experiment {
    pub(super) fn available(&self) -> bool {
        self.status == Status::Available
    }

    pub(super) fn featured(&self) -> bool {
        matches!(self.slug.as_str(), "ldsc" | "rustlyn" | "rust-dotnet")
    }

    pub(super) fn has_demo(&self) -> bool {
        self.status != Status::Planned
    }

    pub(super) fn status_label(&self) -> &'static str {
        match self.status {
            Status::Available => "Try now",
            Status::Study => "Interactive study",
            Status::Recorded => "Recorded result",
            Status::Planned => "Demo planned",
        }
    }
}

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
struct Document {
    experiments: Vec<Experiment>,
}

static CATALOG: LazyLock<Vec<Experiment>> = LazyLock::new(|| {
    let mut document: Document = toml::from_str(include_str!("../content/experiments.toml"))
        .expect("The experiments catalog must contain valid TOML");
    for experiment in &mut document.experiments {
        if let Some(preview) = studies::preview(&experiment.slug) {
            experiment.preview_svg = preview;
            experiment.preview_is_example = true;
        } else {
            experiment.preview_svg = illustration(experiment.category);
        }
    }
    document.experiments
});

pub(super) fn all() -> &'static [Experiment] {
    &CATALOG
}

pub(super) struct Study {
    pub(super) title: &'static str,
    pub(super) intro: &'static str,
    pub(super) method: &'static str,
    pub(super) scenes: Vec<Scene>,
    pub(super) sources: Vec<Source>,
    pub(super) audio: Option<&'static str>,
}

pub(super) struct Scene {
    pub(super) label: String,
    pub(super) title: String,
    pub(super) explanation: String,
    pub(super) svg: String,
    pub(super) image: Option<StudyImage>,
    pub(super) input: String,
    pub(super) output: String,
    pub(super) metrics: Vec<Metric>,
    pub(super) citations: Vec<String>,
}

pub(super) struct StudyImage {
    pub(super) src: String,
    pub(super) width: u32,
    pub(super) height: u32,
}

pub(super) struct Metric {
    pub(super) label: String,
    pub(super) value: String,
}

pub(super) struct Source {
    pub(super) key: String,
    pub(super) title: String,
    pub(super) text: String,
    pub(super) href: Option<String>,
}

pub(super) fn study(slug: &str) -> Option<Study> {
    studies::build(slug)
}

fn illustration(category: Category) -> String {
    let (label, drawing) = match category {
        Category::Numbers => (
            "Concept diagram of a curve and sample points",
            r#"<path d="M25 155H295M35 165V25"/><path d="M40 142C85 140 85 108 132 103S199 76 278 35" stroke-width="4"/><g fill="currentColor" stroke="none"><circle cx="65" cy="137" r="5"/><circle cx="132" cy="103" r="5"/><circle cx="202" cy="74" r="5"/><circle cx="265" cy="43" r="5"/></g>"#,
        ),
        Category::Languages => (
            "Concept diagram of source code and a syntax tree",
            r#"<path d="m55 48-25 42 25 42m210-84 25 42-25 42M110 45h100v35H110zM160 80v25m0 0h-55v30m55-30h55v30M85 135h40v30H85zm110 0h40v30h-40z"/>"#,
        ),
        Category::Media => (
            "Concept diagram of a frame and a playhead",
            r#"<rect x="28" y="25" width="264" height="125" rx="3"/><path d="M28 122h264M55 122l50-65 38 49 35-34 56 50M52 168h216M182 157v22"/><circle cx="241" cy="57" r="14"/>"#,
        ),
        Category::Tools => (
            "Concept diagram of a tool with three measurements",
            r#"<rect x="35" y="30" width="250" height="145" rx="3"/><path d="M35 57h250M63 87h45m-45 30h45m-45 30h45"/><path d="M132 87h121m-121 30h75m-75 30h95" stroke-width="8"/>"#,
        ),
        Category::Knowledge => (
            "Concept diagram of linked documents",
            r#"<path d="M35 55h75v100H35zM210 35h75v100h-75zM60 78h25m-25 20h25m-25 20h25m150-60h25m-25 20h25m-25 20h25M110 105h35V85h65"/><circle cx="160" cy="150" r="20"/><path d="M160 130V85"/>"#,
        ),
    };
    format!(
        r#"<svg viewBox="0 0 320 200" role="img" aria-label="{label}" xmlns="http://www.w3.org/2000/svg"><g fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round" stroke-linecap="round">{drawing}</g></svg>"#
    )
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::BTreeSet;

    #[test]
    fn catalog_has_unique_safe_routes_and_explicit_demo_status() {
        let mut slugs = BTreeSet::new();
        for experiment in all() {
            assert!(slugs.insert(&experiment.slug));
            assert!(!experiment.slug.is_empty());
            assert!(
                experiment
                    .slug
                    .bytes()
                    .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'-')
            );
            assert_eq!(experiment.has_demo(), experiment.demo_href.is_some());
            if let Some(href) = &experiment.demo_href
                && !["/chat/", "/projects/hornet/"].contains(&href.as_str())
            {
                let (route, fragment) = href.split_once('#').expect("An example anchor");
                assert_eq!(route, format!("/experiments/{}/", experiment.slug));
                let axum::response::Html(page) =
                    crate::render_experiment(&experiment.slug).unwrap();
                assert_eq!(page.matches(&format!("id=\"{fragment}\"")).count(), 1);
            }
            for text in [
                &experiment.summary,
                &experiment.scope,
                &experiment.next_step,
                &experiment.rust_plan,
                &experiment.credit,
            ] {
                assert!(!text.is_empty());
                assert!(!text.contains("/Users/") && !text.contains("ai-history-2026"));
            }
        }
        assert_eq!(all().iter().filter(|e| e.available()).count(), 1);
        assert_eq!(all().iter().filter(|e| e.featured()).count(), 3);
    }

    #[test]
    fn every_selected_entry_has_a_complete_example_and_resolvable_sources() {
        for experiment in all() {
            assert!(experiment.has_demo());
            if experiment.available() {
                continue;
            }
            let study = study(&experiment.slug).expect("Each selected entry needs an example");
            assert!((2..=4).contains(&study.scenes.len()));
            let source_keys = study
                .sources
                .iter()
                .map(|source| &source.key)
                .collect::<BTreeSet<_>>();
            assert_eq!(source_keys.len(), study.sources.len());
            for scene in &study.scenes {
                assert!(!scene.label.is_empty() && !scene.title.is_empty());
                assert!(
                    !scene.svg.is_empty()
                        || scene.image.is_some()
                        || !scene.output.is_empty()
                        || !scene.input.is_empty(),
                    "Empty example: {} / {}",
                    experiment.slug,
                    scene.label
                );
                for key in &scene.citations {
                    assert!(source_keys.contains(key));
                }
                for text in [&scene.input, &scene.output, &scene.svg, &scene.explanation] {
                    assert!(!text.contains("/Users/") && !text.contains("ai-history-2026"));
                }
                if let Some(image) = &scene.image {
                    assert!(image.src.starts_with("/static/"));
                    assert!(image.width > 0 && image.height > 0);
                    assert!(
                        std::path::Path::new("static")
                            .join(image.src.trim_start_matches("/static/"))
                            .is_file(),
                        "Missing image: {}",
                        image.src
                    );
                }
            }
            if let Some(audio) = study.audio {
                assert!(audio.starts_with("/static/"));
                assert!(
                    std::path::Path::new("static")
                        .join(audio.trim_start_matches("/static/"))
                        .is_file()
                );
            }
        }
    }
}
