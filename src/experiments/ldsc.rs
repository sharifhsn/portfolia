//! Recorded native results. The page does not run a genome analysis in the browser.
use serde::Deserialize;
use std::sync::LazyLock;

const RESULTS: &str = include_str!("../../static/experiments/fixtures/ldsc/results.json");

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
struct Records {
    snapshot_date: String,
    source_checkout: String,
    benchmark: Benchmark,
    reference: Reference,
    bmi: Bmi,
    sources: Vec<Evidence>,
}

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
struct Benchmark {
    date: String,
    machine: String,
    samples: usize,
    variants: usize,
    window_kb: usize,
    python_seconds: f64,
    python_runs: usize,
    rust_f64_seconds: f64,
    rust_f64_sd: f64,
    rust_f32_seconds: f64,
    rust_f32_sd: f64,
    rust_runs: usize,
    f32_max_abs_difference: f64,
}

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
struct Reference {
    population: String,
    samples: usize,
    chromosome: usize,
    variants: usize,
    maf_min: f64,
    window_kb: usize,
    mean: f64,
    median: f64,
    maximum: f64,
    bins: Vec<Bin>,
}

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
struct Bin {
    lower: usize,
    upper: Option<usize>,
    count: usize,
}

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
struct Bmi {
    merged_variants: usize,
    h2: f64,
    h2_se: f64,
    intercept: f64,
    intercept_se: f64,
    mean_chi2: f64,
    ratio: f64,
    ratio_se: f64,
    reference_samples: usize,
    pipeline_seconds: [usize; 3],
}

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
struct Evidence {
    path: String,
    sha256: String,
}

static RECORDS: LazyLock<Records> = LazyLock::new(|| {
    let records: Records = serde_json::from_str(RESULTS).expect("Valid recorded LDSC results");
    records.validate();
    records
});

impl Records {
    fn validate(&self) {
        let b = &self.benchmark;
        for seconds in [b.python_seconds, b.rust_f64_seconds, b.rust_f32_seconds] {
            assert!(seconds.is_finite() && seconds > 0.0);
        }
        assert!(b.python_runs > 0 && b.rust_runs > 0);
        let r = &self.reference;
        assert_eq!(
            r.bins.iter().map(|bin| bin.count).sum::<usize>(),
            r.variants
        );
        assert!(!r.bins.is_empty() && r.variants > 0 && r.samples > 2);
        for (i, bin) in r.bins.iter().enumerate() {
            assert_eq!(bin.lower, i * 10);
            assert_eq!(bin.upper, (i + 1 < r.bins.len()).then_some((i + 1) * 10));
        }
        assert!(r.mean.is_finite() && r.median.is_finite() && r.maximum.is_finite());
        let bmi = &self.bmi;
        assert!((0.0..=1.0).contains(&bmi.h2) && bmi.h2_se > 0.0);
        assert!((0.0..=1.0).contains(&bmi.ratio));
        // The displayed ratio must agree with the retained rounded regression output.
        let ratio = (bmi.intercept - 1.0) / (bmi.mean_chi2 - 1.0);
        assert!((ratio - bmi.ratio).abs() < 0.0001);
        assert_eq!(bmi.reference_samples, r.samples);
        assert_eq!(self.source_checkout.len(), 40);
        assert!(!self.snapshot_date.is_empty());
        assert_eq!(self.sources.len(), 4);
        for source in &self.sources {
            assert!(!source.path.is_empty());
            assert_eq!(source.sha256.len(), 64);
            assert!(source.sha256.bytes().all(|byte| byte.is_ascii_hexdigit()));
        }
    }
}

pub(crate) struct Engine {
    pub(crate) speedup: String,
    pub(crate) saved_minutes: String,
    pub(crate) benchmark_context: String,
    pub(crate) benchmark_date: String,
    pub(crate) runtimes: Vec<Runtime>,
    pub(crate) f32_error: String,
    pub(crate) reference_context: String,
    pub(crate) reference_svg: String,
    pub(crate) reference_mean: String,
    pub(crate) reference_median: String,
    pub(crate) reference_maximum: String,
    pub(crate) bins: Vec<HistogramRow>,
    pub(crate) bmi_share: String,
    pub(crate) bmi_se: String,
    pub(crate) bmi_intercept: String,
    pub(crate) bmi_ratio: String,
    pub(crate) bmi_variants: String,
    pub(crate) pipeline_total: usize,
    pub(crate) pipeline: [usize; 3],
}

pub(crate) struct Runtime {
    pub(crate) label: &'static str,
    pub(crate) time: String,
    pub(crate) width: String,
    pub(crate) runs: usize,
}

pub(crate) struct HistogramRow {
    pub(crate) range: String,
    pub(crate) count: String,
}

fn grouped(value: usize) -> String {
    let digits = value.to_string();
    digits
        .chars()
        .enumerate()
        .fold(String::new(), |mut out, (i, c)| {
            if i > 0 && (digits.len() - i).is_multiple_of(3) {
                out.push(',');
            }
            out.push(c);
            out
        })
}

fn histogram(reference: &Reference) -> String {
    let maximum = reference
        .bins
        .iter()
        .map(|bin| bin.count)
        .max()
        .unwrap_or(1) as f64;
    let mut drawing = String::from(
        r#"<path d="M48 28V220H463" fill="none" stroke="currentColor" opacity=".4"/><text x="48" y="18">Variants per interval</text>"#,
    );
    for (i, bin) in reference.bins.iter().enumerate() {
        let x = 51 + i * 37;
        let height = bin.count as f64 / maximum * 174.0;
        let y = 220.0 - height;
        drawing.push_str(&format!(
            r#"<rect x="{x}" y="{y:.2}" width="31" height="{height:.2}" opacity=".72"><title>LD score {}: {} variants</title></rect>"#,
            bin.lower, grouped(bin.count),
        ));
        if i.is_multiple_of(2) {
            drawing.push_str(&format!(
                r#"<text x="{}" y="242" text-anchor="middle">{}{}</text>"#,
                x + 15,
                bin.lower,
                if bin.upper.is_none() { "+" } else { "" }
            ));
        }
    }
    drawing.push_str(&format!(r#"<text x="43" y="48" text-anchor="end" font-size="12">{}</text><text x="43" y="222" text-anchor="end" font-size="12">0</text><text x="250" y="273" text-anchor="middle">LD score</text>"#, grouped(maximum as usize)));
    super::studies::svg(
        "Distribution of 18,627 recorded Rust LD scores on 1000G chromosome 22",
        &drawing,
    )
}

pub(crate) fn build() -> Engine {
    let records = &*RECORDS;
    let b = &records.benchmark;
    let r = &records.reference;
    let bmi = &records.bmi;
    let runtime = |label, seconds, deviation, runs| Runtime {
        label,
        time: if let Some(sd) = deviation {
            format!("{seconds:.1} s ± {sd:.1}")
        } else {
            format!("{seconds:.1} s")
        },
        width: format!("{:.3}", seconds / b.python_seconds * 100.0),
        runs,
    };
    Engine {
        speedup: format!("{:.1}", b.python_seconds / b.rust_f64_seconds),
        saved_minutes: format!("{:.1}", (b.python_seconds - b.rust_f64_seconds) / 60.0),
        benchmark_context: format!(
            "{} variants · {} reference samples · {} kb window · {}",
            grouped(b.variants),
            grouped(b.samples),
            b.window_kb,
            b.machine
        ),
        benchmark_date: b.date.clone(),
        runtimes: vec![
            runtime("Python LDSC", b.python_seconds, None, b.python_runs),
            runtime(
                "Rust exact f64",
                b.rust_f64_seconds,
                Some(b.rust_f64_sd),
                b.rust_runs,
            ),
            runtime(
                "Rust f32",
                b.rust_f32_seconds,
                Some(b.rust_f32_sd),
                b.rust_runs,
            ),
        ],
        f32_error: format!("{:.3}", b.f32_max_abs_difference),
        reference_context: format!(
            "{} variants · {} samples of {} · chromosome {} · MAF > {}% · {} kb window",
            grouped(r.variants),
            r.samples,
            r.population.to_lowercase(),
            r.chromosome,
            r.maf_min * 100.0,
            r.window_kb
        ),
        reference_svg: histogram(r),
        reference_mean: format!("{:.2}", r.mean),
        reference_median: format!("{:.2}", r.median),
        reference_maximum: format!("{:.2}", r.maximum),
        bins: r
            .bins
            .iter()
            .map(|bin| HistogramRow {
                range: bin.upper.map_or_else(
                    || format!("{}+", bin.lower),
                    |upper| format!("{}–{upper}", bin.lower),
                ),
                count: grouped(bin.count),
            })
            .collect(),
        bmi_share: format!("{:.2}", bmi.h2 * 100.0),
        bmi_se: format!("{:.2}", bmi.h2_se * 100.0),
        bmi_intercept: format!("{:.4} ± {:.4}", bmi.intercept, bmi.intercept_se),
        bmi_ratio: format!("{:.2}% ± {:.2}", bmi.ratio * 100.0, bmi.ratio_se * 100.0),
        bmi_variants: grouped(bmi.merged_variants),
        pipeline_total: bmi.pipeline_seconds.iter().sum(),
        pipeline: bmi.pipeline_seconds,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn recorded_results_preserve_counts_and_regression_relationship() {
        RECORDS.validate();
        assert_eq!(RECORDS.reference.variants, 18_627);
        assert_eq!(RECORDS.reference.chromosome, 22);
        assert_eq!(RECORDS.benchmark.samples, 2_490);
        assert_ne!(RECORDS.benchmark.samples, RECORDS.reference.samples);
        let engine = build();
        assert_eq!(engine.speedup, "18.1");
        assert_eq!(engine.bmi_share, "20.32");
        assert_eq!(engine.pipeline_total, 41);
        assert_eq!(engine.runtimes[0].width, "100.000");
        assert!(
            engine
                .runtimes
                .iter()
                .all(|row| row.width.parse::<f64>().unwrap() <= 100.0)
        );
    }

    #[test]
    #[should_panic]
    fn invalid_histogram_cannot_enter_the_display() {
        let mut records: Records = serde_json::from_str(RESULTS).unwrap();
        records.reference.bins[0].count += 1;
        records.validate();
    }

    #[test]
    #[should_panic]
    fn inconsistent_bmi_ratio_cannot_enter_the_display() {
        let mut records: Records = serde_json::from_str(RESULTS).unwrap();
        records.bmi.ratio = 0.1;
        records.validate();
    }
}
