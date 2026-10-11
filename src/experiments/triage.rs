//! Public issue evidence. Recorded measurements are distinct from current issue states.
use super::{Metric, Scene, Source, Study};
use serde::Deserialize;
use std::sync::LazyLock;

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
struct Evidence {
    checked_on: String,
    benchmark_posted_on: String,
    benchmarks: Vec<Benchmark>,
    issues: Vec<PublicIssue>,
}

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
struct Benchmark {
    members: u32,
    before_ms: f64,
    before_stddev_ms: f64,
    after_ms: f64,
    after_stddev_ms: f64,
}

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
struct PublicIssue {
    key: String,
    title: String,
    href: String,
    evidence_href: String,
    kind: String,
    state: String,
    quote: String,
}

static EVIDENCE: LazyLock<Evidence> = LazyLock::new(|| {
    let evidence: Evidence = serde_json::from_str(include_str!(
        "../../static/experiments/github-triage/evidence.json"
    ))
    .expect("Public triage evidence must contain valid JSON");
    for issue in &evidence.issues {
        assert!(
            issue.evidence_href == issue.href
                || issue
                    .evidence_href
                    .starts_with(&format!("{}#issuecomment-", issue.href)),
            "A verification comment must belong to its cited issue"
        );
    }
    evidence
});

fn issue(key: &str) -> &'static PublicIssue {
    EVIDENCE
        .issues
        .iter()
        .find(|issue| issue.key == key)
        .expect("Every investigation must have a public source")
}

pub(super) fn workflow_svg() -> String {
    include_str!("../../static/experiments/github-triage/workflow.svg").into()
}

fn metric(label: &str, value: impl Into<String>) -> Metric {
    Metric {
        label: label.into(),
        value: value.into(),
    }
}

fn scene(label: &str, title: &str, explanation: &str, key: &str) -> Scene {
    Scene {
        label: label.into(),
        title: title.into(),
        explanation: explanation.into(),
        svg: String::new(),
        image: None,
        input: String::new(),
        output: String::new(),
        metrics: vec![
            metric("Public issue", issue(key).state.clone()),
            metric("State checked", EVIDENCE.checked_on.clone()),
        ],
        citations: vec![key.into()],
    }
}

fn svg(label: &str, drawing: &str) -> String {
    super::studies::svg(label, drawing)
}

fn performance_svg() -> String {
    // All four recorded means use the same 0–700 ms axis.
    let mut drawing = String::from(
        r#"<text x="16" y="24" font-size="17">Mean runtime (ms), lower is faster</text>"#,
    );
    for (index, benchmark) in EVIDENCE.benchmarks.iter().enumerate() {
        let group_y = 50 + index * 112;
        drawing.push_str(&format!(
            r#"<text x="16" y="{group_y}" font-size="18">{} workspace members</text>"#,
            benchmark.members
        ));
        for (row, version, mean, color) in [
            (0, "0.6.5", benchmark.before_ms, "#8a6b4d"),
            (1, "0.6.6", benchmark.after_ms, "#386675"),
        ] {
            let y = group_y + 14 + row * 33;
            let width = mean / 700.0 * 285.0;
            drawing.push_str(&format!(
                r#"<text x="16" y="{}" font-size="18">{version}</text><rect x="105" y="{y}" width="{width:.2}" height="22" fill="{color}"/><text x="406" y="{}" font-size="18">{mean:.1}</text>"#,
                y + 18,
                y + 18
            ));
        }
    }
    drawing.push_str(
        r#"<path d="M105 246H390" stroke="currentColor" stroke-opacity=".4"/><g font-size="16"><text x="105" y="270">0</text><text x="237" y="270">350</text><text x="375" y="270">700</text></g>"#,
    );
    svg(
        "Recorded uv runtimes: 213.8 and 53.7 milliseconds at 100 members, 694.0 and 69.0 milliseconds at 200 members. All bars share one scale.",
        &drawing,
    )
}

pub(super) fn build() -> Study {
    let mut boundary = scene(
        "Release boundary",
        "Connect an old issue to the release that fixed it",
        "uv #3841 asked for a useful hint when interpreter discovery filtered out system Python. My comment runs the same command on 0.4.7 and 0.4.8: the error gains the missing guidance. I linked charliermarsh’s #7188, which had closed a different issue. This issue closed after my May 18 comment.",
        "uv3841",
    );
    boundary.svg = svg(
        "uv 0.4.7 gives an error without guidance. uv 0.4.8 adds instructions to create a virtual environment or use system Python.",
        r#"<g fill="none" stroke="currentColor" stroke-width="2"><rect x="20" y="38" width="440" height="83" rx="4"/><rect x="20" y="159" width="440" height="83" rx="4"/><path d="M240 121v38m-7-10 7 10 7-10"/></g><g font-size="21"><text x="40" y="70">uv 0.4.7</text><text x="40" y="101" font-size="18">No virtual environment found</text><text x="40" y="191">uv 0.4.8</text><text x="40" y="222" font-size="18">Create a venv, or use --system</text></g>"#,
    );
    boundary.input =
        "UV_PYTHON_DOWNLOADS=never UV_NO_MANAGED_PYTHON=1 uv pip install --python 3.9 requests"
            .into();
    boundary.output = "uv 0.4.7:\nerror: No virtual environment found for Python 3.9\n\nuv 0.4.8:\nerror: No virtual environment found for Python 3.9; run `uv venv` to create an environment, or pass `--system` to install into a non-virtual environment".into();

    let mut performance = scene(
        "Performance",
        "Increase the input and check that the improvement holds",
        "uv #3937 tracked repeated workspace discovery. My published comparison tests the releases around konstin’s #12096 and repeats the benchmark at twice the workspace size. The measured speedup grows from 3.98× at 100 members to 10.06× at 200. The chart uses the same time scale for both sizes.",
        "uv3937",
    );
    performance.svg = performance_svg();
    performance.input = "Fixture: a root project depending on anyio, with pkgs/* workspace members\nPayload: uv run --no-dev python -c 'print(1)'\nVersions: uv 0.6.5 and 0.6.6\n100-member benchmark: 3 warmups, 10 measured runs\nRepeat at 200 members".into();
    performance.output = EVIDENCE
        .benchmarks
        .iter()
        .map(|benchmark| {
            format!(
                "{} members:\nuv 0.6.5: {:.1} ± {:.1} ms\nuv 0.6.6: {:.1} ± {:.1} ms\nMean ratio: {:.2}×\n",
                benchmark.members,
                benchmark.before_ms,
                benchmark.before_stddev_ms,
                benchmark.after_ms,
                benchmark.after_stddev_ms,
                benchmark.before_ms / benchmark.after_ms,
            )
        })
        .collect::<Vec<_>>()
        .join("\n");
    performance.metrics = EVIDENCE
        .benchmarks
        .iter()
        .map(|benchmark| {
            metric(
                &format!("{} members", benchmark.members),
                format!("{:.2}× faster", benchmark.before_ms / benchmark.after_ms),
            )
        })
        .chain([
            metric("Benchmark posted", EVIDENCE.benchmark_posted_on.clone()),
            metric("Public issue", issue("uv3937").state.clone()),
        ])
        .collect();

    let mut linker = scene(
        "Minimal bug",
        "Make a linker crash small enough to explain",
        "My Wild report combines a padded thread-local section with debug compression. Recomputing section offsets discarded the padding, so allocated contents moved away from the program headers that described them. lapla-cogito’s #2644 preserves those offsets and repacks only the non-allocated tail. The issue closed when that fix merged on October 2.",
        "wild2616",
    );
    linker.svg = svg(
        "Concept diagram: the layout includes padding before thread-local data. Compression drops that padding and shifts the data away from its expected position. The diagram does not represent measured byte offsets.",
        r##"<g font-size="18"><text x="20" y="42">Layout: padding keeps data aligned</text><text x="20" y="153">Broken compression: padding removed</text></g><g fill="none" stroke="currentColor" stroke-width="2"><rect x="20" y="60" width="90" height="50" stroke-dasharray="5 4"/><rect x="110" y="60" width="350" height="50"/><rect x="20" y="171" width="350" height="50" fill="#f1e5d8"/><path d="M110 110v131" stroke-dasharray="5 4"/></g><g font-size="18"><text x="33" y="91">padding</text><text x="129" y="91">.tdata / .dynamic</text><text x="38" y="202">.tdata / .dynamic shifted</text><text x="20" y="270" font-size="16">Concept diagram. Positions are schematic.</text></g>"##,
    );
    linker.input = "static __thread volatile long a = 0x1122334455667788;\nstatic __thread volatile _Alignas(64) unsigned char b[3];\nint main(void) { return a != 0x1122334455667788 || b[0]; }\n\nclang -g t.c --ld-path=wild -Wl,--compress-debug-sections=zlib -o t && ./t".into();
    linker.output = "Published reproduction on Wild 086d0ec2:\nWith zlib compression: segfault\nWith zstd compression: segfault\nWithout debug compression: exit 0\n\nPlatforms: x86_64 and aarch64, Debian 12\nFix: wild-linker/wild #2644 (merged)".into();

    let mut ownership = scene(
        "Ownership",
        "Follow the lifetime beyond the parent process",
        "My uv cleanup report closed after #22171 added pruning of temporary build environments. The separate #22338 report documents a live backend losing its files after uv dies, and another case after a parallel build fails. I proposed moving execution workspaces outside the evictable cache and retaining them when descendant lifetime is unknown. That proposal remains open and has no implementation or Linux/Windows runtime validation.",
        "uv22338",
    );
    ownership.svg = svg(
        "The published failure: uv exits, a backend remains alive, and cache cleanup removes files the backend still needs. The proposed ownership model retains the execution workspace through process exit and output collection.",
        r##"<g font-size="19"><text x="24" y="34">Observed failure</text><text x="24" y="173">Proposed ownership model</text></g><g fill="none" stroke="currentColor" stroke-width="2"><rect x="24" y="50" width="190" height="67"/><rect x="266" y="50" width="190" height="67"/><path d="M214 83h52m-10-7 10 7-10 7"/><rect x="24" y="190" width="432" height="64"/></g><g font-size="18"><text x="39" y="77">Backend still alive</text><text x="39" y="103">uv has exited</text><text x="281" y="77">Cache removes files</text><text x="281" y="103">Next write: ENOENT</text><text x="42" y="217">Keep execution workspace through exit</text><text x="42" y="241">Collect output, then release ownership</text></g>"##,
    );
    ownership.input = "Case A: kill only uv, then run plain uv cache clean\nCase B: one parallel build fails while another backend is alive\nRelated case: a detached descendant closes its output pipes".into();
    ownership.output = "Recorded macOS arm64 reproduction:\nThe backend stays alive\nIts execution environment is removed\nThe next write fails with ENOENT\n\nCleanup report #22167: closed\nOwnership proposal #22338: open\nArchitecture implementation: pending\nLinux / Windows runtime checks: pending".into();
    ownership.citations.push("uv22167".into());

    Study {
        title: "Four investigations, four kinds of evidence",
        intro: "Choose a published example. Each view connects the reported problem, the check that makes it concrete, and the outcome recorded on GitHub.",
        method: "Rust renders the linked reports and comments from the public evidence snapshot. The runtime measurements were published on May 18, 2026. Issue states were checked on October 11, 2026. The diagrams explain the recorded behavior, and the original sources preserve the reproduction commands and results.",
        scenes: vec![boundary, performance, linker, ownership],
        sources: EVIDENCE
            .issues
            .iter()
            .map(|issue| Source {
                key: issue.key.clone(),
                title: format!("{}: {}", issue.kind, issue.title),
                text: issue.quote.clone(),
                href: Some(issue.evidence_href.clone()),
            })
            .collect(),
        audio: None,
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::BTreeSet;

    #[test]
    fn published_benchmarks_share_a_scale_and_sources_are_public_github_links() {
        let mut keys = BTreeSet::new();
        for issue in &EVIDENCE.issues {
            assert!(keys.insert(&issue.key));
            for href in [&issue.href, &issue.evidence_href] {
                assert!(href.starts_with("https://github.com/"));
                assert!(href.contains("/issues/"));
            }
            assert!(["Open", "Closed"].contains(&issue.state.as_str()));
        }
        for benchmark in &EVIDENCE.benchmarks {
            assert!(benchmark.before_ms.is_finite() && benchmark.before_ms <= 700.0);
            assert!(benchmark.after_ms.is_finite() && benchmark.after_ms > 0.0);
            assert!(benchmark.after_ms < benchmark.before_ms);
        }
        let study = build();
        let performance = &study.scenes[1];
        assert!(performance.output.contains("Mean ratio: 3.98×"));
        assert!(performance.output.contains("Mean ratio: 10.06×"));
        assert!(performance.svg.contains("width=\"282.56\""));
        assert!(performance.svg.contains("width=\"28.09\""));
    }
}
