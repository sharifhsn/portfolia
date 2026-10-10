//! Bounded examples for the public collection. No private source enters a view.
use super::{Metric, Scene, Source, Study, StudyImage};

mod additions;

pub(super) fn preview(slug: &str) -> Option<String> {
    if slug == "ldsc" {
        return Some(super::ldsc::build().reference_svg);
    }
    build(slug)?.scenes.into_iter().find_map(|scene| {
        if !scene.svg.is_empty() {
            Some(scene.svg)
        } else {
            scene.image.map(|image| svg("A visual from the recorded example", &format!(r#"<image href="{}" x="80" y="15" width="320" height="250" preserveAspectRatio="xMidYMid meet"/>"#, escape(&image.src))))
        }
    })
}

pub(super) fn build(slug: &str) -> Option<Study> {
    Some(match slug {
        "ldsc" => ldsc(),
        "system-health" => system_health(),
        "volt" => volt(),
        "wedeo" => wedeo(),
        "tylax" => tylax(),
        "rustlyn" => rustlyn(),
        "rust-dotnet" => compiler(false),
        "rust-swift" => compiler(true),
        "plume" => battle(),
        "bevy-switch" => graphics(),
        "ttfx" => terminal(),
        "raygeo" => geometry(),
        "booksharp" => basketball(),
        "dailyreddit" => retrieval("thread"),
        "docs-cli" => retrieval("document"),
        "paper-reader" => retrieval("paper"),
        "discord-audio" => retrieval("audio"),
        "home-inventory" => inventory(),
        "numerical-ports" => numerical(),
        other => return additions::build(other),
    })
}

fn scene(
    label: impl Into<String>,
    title: impl Into<String>,
    explanation: impl Into<String>,
) -> Scene {
    Scene {
        label: label.into(),
        title: title.into(),
        explanation: explanation.into(),
        svg: String::new(),
        image: None,
        input: String::new(),
        output: String::new(),
        metrics: Vec::new(),
        citations: Vec::new(),
    }
}

fn metric(label: &str, value: impl ToString) -> Metric {
    Metric {
        label: label.into(),
        value: value.to_string(),
    }
}

fn source(key: &str, title: &str, text: &str, href: Option<&str>) -> Source {
    Source {
        key: key.into(),
        title: title.into(),
        text: text.into(),
        href: href.map(str::to_owned),
    }
}

fn escape(text: &str) -> String {
    text.replace('&', "&amp;")
        .replace('<', "&lt;")
        .replace('>', "&gt;")
        .replace('"', "&quot;")
}

pub(super) fn svg(label: &str, drawing: &str) -> String {
    format!(
        r#"<svg viewBox="0 0 480 280" role="img" aria-label="{}" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="15" fill="currentColor">{drawing}</g></svg>"#,
        escape(label)
    )
}

fn bar(label: &str, value: f64, max: f64, y: usize) -> String {
    let width = (value / max * 285.0).clamp(0.0, 285.0);
    format!(
        r#"<text x="16" y="{}">{}</text><rect x="135" y="{}" width="{width:.2}" height="24" opacity=".65"/><text x="435" y="{}">{value:.1}</text>"#,
        y + 18,
        escape(label),
        y,
        y + 18
    )
}

fn correlation(a: &[f64], b: &[f64]) -> f64 {
    assert_eq!(a.len(), b.len());
    let n = a.len() as f64;
    let mean_a = a.iter().sum::<f64>() / n;
    let mean_b = b.iter().sum::<f64>() / n;
    let covariance = a
        .iter()
        .zip(b)
        .map(|(x, y)| (x - mean_a) * (y - mean_b))
        .sum::<f64>();
    let variance =
        |values: &[f64], mean: f64| values.iter().map(|x| (x - mean).powi(2)).sum::<f64>();
    covariance / (variance(a, mean_a) * variance(b, mean_b)).sqrt()
}

fn ld_scores(columns: &[[f64; 6]; 3], corrected: bool, neighbors_only: bool) -> Vec<f64> {
    columns
        .iter()
        .enumerate()
        .map(|(i, a)| {
            columns
                .iter()
                .enumerate()
                .filter(|(j, _)| !neighbors_only || i.abs_diff(*j) <= 1)
                .map(|(_, b)| {
                    let squared = correlation(a, b).powi(2);
                    if corrected {
                        squared - (1.0 - squared) / 4.0
                    } else {
                        squared
                    }
                })
                .sum()
        })
        .collect()
}

fn ldsc() -> Study {
    let columns = [
        [0., 0., 1., 1., 2., 2.],
        [0., 1., 0., 2., 1., 2.],
        [2., 2., 1., 1., 0., 0.],
    ];
    let scenes = [("Raw r²", false, false), ("Corrected", true, false), ("Short window", true, true)].into_iter().map(|(label, corrected, window)| {
        let scores = ld_scores(&columns, corrected, window);
        let mut result = scene(label, "Three variants, six synthetic samples", if window {
            "The short window omits the distant pair. The input stays the same, but the scores change."
        } else if corrected {
            "The finite-sample correction uses r² − (1 − r²) / (N − 2), with N = 6. Negative contributions remain possible."
        } else { "Each score sums squared correlations across all three variants, with the self-correlation included." });
        result.svg = svg("LD scores for three synthetic variants", &scores.iter().enumerate().map(|(i, value)| bar(&format!("Variant {}", i + 1), *value, 3.0, 50 + i * 65)).collect::<String>());
        result.input = "A: 0 0 1 1 2 2\nB: 0 1 0 2 1 2\nC: 2 2 1 1 0 0".into();
        result.output = scores.iter().enumerate().map(|(i, score)| format!("Variant {}: {score:.6}\n", i + 1)).collect();
        result.metrics = vec![metric("Samples", 6), metric("Variants", 3), metric("Mode", label)];
        result
    }).collect();
    Study {
        title: "Follow the calculation with three variants",
        intro: "Start with six samples and three variants. Compare the raw sum, the finite-sample correction, and a shorter window to see why each choice changes the LD score.",
        method: "Rust calculates this small example from synthetic genotypes. It illustrates the LD-score formula, while the full regression and sketch modes run in the native engine.",
        scenes,
        sources: vec![
            source(
                "ldsc-method",
                "LD Score regression distinguishes confounding from polygenicity",
                "quantifies the contribution of each by examining the relationship between test statistics and linkage disequilibrium (LD).",
                Some("https://www.nature.com/articles/ng.3211"),
            ),
            source(
                "ldsc-cross-trait",
                "An atlas of genetic correlations across human diseases and traits",
                "estimating genetic correlation that requires only GWAS summary statistics and is not biased by sample overlap.",
                Some("https://pubmed.ncbi.nlm.nih.gov/26414676/"),
            ),
        ],
        audio: None,
    }
}

#[derive(Debug, PartialEq, Eq)]
enum MeasurementState {
    Current,
    Stale,
    Missing,
}

fn measurement_state(value: Option<f64>, age: Option<u64>) -> MeasurementState {
    match (value, age) {
        (Some(value), Some(age)) if value.is_finite() && (0.0..=100.0).contains(&value) => {
            if age <= 60 {
                MeasurementState::Current
            } else {
                MeasurementState::Stale
            }
        }
        _ => MeasurementState::Missing,
    }
}

fn system_health() -> Study {
    let scenes = [("Current", Some(18.0), Some(4)), ("Stale", Some(82.0), Some(420)), ("Missing", None, None)].into_iter().map(|(label, cpu, age)| {
        let state = measurement_state(cpu, age);
        let mut result = scene(label, format!("Synthetic host: {label}"), match state {
            MeasurementState::Current => "The CPU sample is four seconds old. Its age keeps the value tied to the time of measurement.",
            MeasurementState::Stale => "Seven minutes passed since this CPU sample. The panel keeps the value visible and marks it stale, so its age travels with it.",
            MeasurementState::Missing => "The CPU sample is missing. The panel reports that state explicitly instead of substituting a zero-percent reading.",
        });
        result.svg = svg("Synthetic memory, disk, and CPU measurements", &format!("{}{}{}", bar("Memory %", 56.0, 100.0, 45), bar("Disk %", 31.0, 100.0, 115), cpu.map_or_else(|| "<text x=\"16\" y=\"208\">CPU: unavailable</text>".into(), |value| bar("CPU %", value, 100.0, 185))));
        result.metrics = vec![metric("CPU state", label), metric("CPU sample age", age.map_or_else(|| "Unknown".into(), |seconds| format!("{seconds} seconds"))), metric("Memory", "56% of 16 GiB")];
        result.input = format!("cpu_percent: {cpu:?}\ncpu_age_seconds: {age:?}\nmemory_percent: 56\ndisk_percent: 31");
        result.output = format!("CPU state: {state:?}");
        result
    }).collect();
    Study {
        title: "A measurement needs an age",
        intro: "The same panel tells a different story when its sample is fresh, seven minutes old, or missing. Switch between those states with synthetic host data.",
        method: "Rust checks each synthetic value and its sample age, then classifies the measurement as current, stale, or missing.",
        scenes,
        sources: vec![],
        audio: None,
    }
}

fn volt() -> Study {
    let mut original = scene(
        "Input",
        "32 bytes to preserve",
        "The file starts as 32 bytes of text. Volt's native Rust encoder turns it into three QR frames.",
    );
    original.input = include_str!("../../content/experiment-fixtures/volt-message.txt").into();
    original.metrics = vec![
        metric("File size", "32 bytes"),
        metric("Frames", 3),
        metric("Mode", "Volt QR"),
    ];
    let mut encoded = scene(
        "Frame",
        "The encoded QR frame",
        "The native Rust encoder produced this PNG. The decoder reads the generated image to recover the file.",
    );
    encoded.image = Some(StudyImage {
        src: "/static/experiments/volt/frame.png".into(),
        width: 93,
        height: 93,
    });
    let mut recovered = scene(
        "Recovered",
        "The original bytes returned",
        "One accepted frame was enough for the native Rust decoder to recover the file. Every byte matches the original input.",
    );
    recovered.output = include_str!("../../content/experiment-fixtures/volt-message.txt").into();
    recovered.metrics = vec![
        metric("Accepted frames", 1),
        metric("Byte comparison", "Equal"),
    ];
    recovered.input =
        "SHA-256\n1f616d44328815fcf2cabb78bf3ebf33803c1337ab963bd983f76bf9b77ec85d".into();
    Study {
        title: "Follow the bytes through a frame",
        intro: "Follow the file from text to a QR frame and back to the original bytes.",
        method: "Volt's native Rust commands encode and decode this recorded example. The input to the decoder is the generated PNG. The next device test uses a camera capture.",
        scenes: vec![original, encoded, recovered],
        sources: vec![],
        audio: None,
    }
}

fn wedeo() -> Study {
    let checksums = ["0xf1b9e679", "0x429be54f", "0x5566e611"];
    let scenes = checksums.into_iter().enumerate().map(|(index, checksum)| {
        let mut result = scene(format!("Frame {}", index + 1), "A 32 × 32 synthetic H.264 frame", "Both decoders produced the same raw YUV bytes. The PNG displays Wedeo's decoded output, while the checksums compare the bytes behind it.");
        result.image = Some(StudyImage { src: format!("/static/experiments/wedeo/frame-{}.png", index + 1), width: 32, height: 32 });
        result.metrics = vec![metric("Frame bytes", 1536), metric("Frame checksum", checksum), metric("Reference", "Equal")];
        result.output = format!("Wedeo: {checksum}\nFFmpeg: {checksum}\nFormat: YUV420p\nDimensions: 32 × 32");
        result
    }).collect();
    Study {
        title: "Three frames, two decoders",
        intro: "Give Wedeo and FFmpeg the same synthetic H.264 input, then compare each decoded frame's checksum.",
        method: "This native comparison uses baseline H.264 with three intra frames. The complete 4,608-byte YUV output matches FFmpeg. The next comparison adds another decoder fixture.",
        scenes,
        sources: vec![],
        audio: None,
    }
}

fn tylax() -> Study {
    let examples = [
        (
            "Fraction",
            "equation",
            include_str!("../../content/experiment-fixtures/equation.tex"),
            include_str!("../../content/experiment-fixtures/equation.typ"),
        ),
        (
            "Matrix",
            "matrix",
            include_str!("../../content/experiment-fixtures/matrix.tex"),
            include_str!("../../content/experiment-fixtures/matrix.typ"),
        ),
        (
            "Sum",
            "sum",
            include_str!("../../content/experiment-fixtures/sum.tex"),
            include_str!("../../content/experiment-fixtures/sum.typ"),
        ),
    ];
    let scenes = examples.into_iter().map(|(label, name, input, output)| {
        let mut result = scene(label, "From LaTeX source to Typst output", "The source becomes a Typst document with a rendered preview. Tylax reports Degraded because amsmath has no active handler, even though the converted math compiles.");
        result.input = input.into(); result.output = output.into();
        let (width, height) = match name { "equation" => (77, 57), "matrix" => (72, 64), "sum" => (128, 67), _ => unreachable!("The fixed examples contain only three math fixtures") };
        result.image = Some(StudyImage { src: format!("/static/experiments/tylax/{name}.svg"), width, height });
        result.metrics = vec![metric("Converter", "Tylax 0.3.6"), metric("Artifact grade", "Degraded"), metric("Preview compiler", "Typst 0.15.1")];
        result
    }).collect();
    Study {
        title: "Follow the mathematics into Typst",
        intro: "Choose a fraction, matrix, or sum and compare its LaTeX source, converted Typst, and preview.",
        method: "The native Rust converter produces the recorded output, and Typst 0.15.1 renders the preview. The artifact grade identifies the amsmath handler to fix next. SciPenAI authors Tylax.",
        scenes,
        sources: vec![source(
            "tylax",
            "Upstream converter",
            "Reference: Tylax by SciPenAI. The examples record output from the native Rust converter and preserve its artifact grades.",
            Some("https://github.com/scipenai/tylax"),
        )],
        audio: None,
    }
}

fn rustlyn() -> Study {
    let mut unresolved = scene(
        "Missing name",
        "Keep the error attached to its source",
        "The binder records missingName as an unresolved value and keeps its byte range, 8..19, with the error. The source line shows where that range points.",
    );
    unresolved.input = "var x = missingName;\n        ^^^^^^^^^^^".into();
    unresolved.output =
        "ResolveLookup::Value\nResolveFailureReason::NotFound\nname: missingName\nrange: 8..19"
            .into();
    unresolved.svg = svg(
        "An error points to an eleven-byte source span",
        "<text x=\"35\" y=\"95\" font-family=\"monospace\" font-size=\"23\">var x = missingName;</text><path d=\"M146 110H298\" stroke=\"currentColor\" stroke-width=\"3\"/><path d=\"M222 120V165\" stroke=\"currentColor\"/><text x=\"115\" y=\"200\">Unresolved value at bytes 8..19</text>",
    );
    unresolved.metrics = vec![metric("Lookup", "Value"), metric("Source span", "11 bytes")];
    let mut identity = scene(
        "Identity",
        "One error, one owning source",
        "The bound expression owns the resolution failure. The caller reads that error directly instead of repeating the name lookup.",
    );
    identity.input = "expression → owning body → source range".into();
    identity.output = "bound_body.resolution_failure_for_expr(...)\n  → NotFound { lookup: Value, name: missingName }".into();
    Study {
        title: "Trace a diagnostic back to its source",
        intro: "An unresolved name needs a useful location. Inspect the name, the bound expression, and the source range the Rustlyn binder attaches to it.",
        method: "The native binder fixture constructs the unresolved expression and records its assigned range. The C# line illustrates that range. The next integration connects the result to a live editor.",
        scenes: vec![unresolved, identity],
        sources: vec![],
        audio: None,
    }
}

fn compiler(swift: bool) -> Study {
    let mut source_scene = scene(
        "Source",
        "The source function",
        if swift {
            "Rust and Swift each compile an independent add-one function. Their four native results agree."
        } else {
            "The Rust-to-.NET backend compiles this function into a managed program. The recorded program returns the same four results as native Rust."
        },
    );
    source_scene.input = if swift {
        "pub fn add_one(x: i32) -> i32 { x + 1 }"
    } else {
        include_str!("../../content/experiment-fixtures/rust-dotnet.rs")
    }
    .into();
    source_scene.output = if swift {
        "public func addOne(_ x: Int32) -> Int32 { x + 1 }"
    } else {
        "cargo dotnet run ./fixture --offline\n\n[profile.release]\noverflow-checks = true"
    }
    .into();
    let mut ir = scene(
        "Compiler output",
        if swift {
            "Actual MIR and SIL"
        } else {
            "A generated managed assembly"
        },
        if swift {
            "The two compilers emitted these forms independently. There is no MIR-to-SIL translator in this example."
        } else {
            "The backend emitted a PE assembly for .NET 10. The fixture enables overflow checks. Its four inputs stay within the Int32 range."
        },
    );
    ir.input = include_str!("../../content/experiment-fixtures/add-one.mir").into();
    ir.output = if swift {
        include_str!("../../content/experiment-fixtures/add-one.sil").into()
    } else {
        format!(
            "Artifact: portfolia-add-one.dll\nRuntime: .NET 10\nSDK: cargo-dotnet 0.0.1\nToolchain: nightly-2026-06-17\nSHA-256: {}",
            include_str!("../../content/experiment-fixtures/dotnet-assembly-sha256.txt").trim()
        )
    };
    let mut values = scene(
        "Results",
        "Four native reference inputs",
        if swift {
            "Rust and Swift each produced these four lines. The inputs stay within the Int32 range."
        } else {
            "The managed program produced these four lines. Its output matches the native Rust reference byte for byte."
        },
    );
    values.input = include_str!("../../content/experiment-fixtures/native-result.txt").into();
    values.output = if swift {
        include_str!("../../content/experiment-fixtures/swift-result.txt")
    } else {
        include_str!("../../content/experiment-fixtures/dotnet-result.txt")
    }
    .into();
    values.metrics = vec![metric("Cases", 4), metric("Reference comparison", "Equal")];
    Study {
        title: if swift {
            "Compare two compiler outputs"
        } else {
            "One function on .NET"
        },
        intro: "Follow the function from source to compiler output, then compare its execution results.",
        method: if swift {
            "The example compares two separate native programs. Rust generates the page. The historical MIR-to-SIL backend remains a design proposal."
        } else {
            "The recorded run uses cargo-dotnet 0.0.1 and nightly-2026-06-17. It compares four inputs within the Int32 range. The next run builds from the newer source checkout. FractalFir authors rustc_codegen_clr."
        },
        scenes: vec![source_scene, ir, values],
        sources: vec![],
        audio: None,
    }
}

fn damage(power: i32, armor: i32, defending: bool) -> i32 {
    let base = (power - armor).max(0);
    if defending { base / 2 } else { base }
}

fn battle() -> Study {
    let scenes = [("Before", 0, false), ("Attack", 18, false), ("Defend", 18, true)].into_iter().map(|(label, power, defending)| {
        let dealt = damage(power, 6, defending);
        let health = 40 - dealt;
        let mut result = scene(label, "One deterministic turn", "Damage starts with attack power minus armor, with zero as the minimum. Defense halves that damage using integer division. The same inputs give the same result.");
        result.svg = svg("Two original game pieces and a target health bar", &format!(r#"<path d="M92 48l42 24v48l-42 24-42-24V72z" fill="currentColor" opacity=".8"/><path d="M345 48l42 24v48l-42 24-42-24V72z" fill="currentColor" opacity=".4"/><text x="53" y="175">Explorer</text><text x="308" y="175">Guardian</text><path d="M160 95H280" stroke="currentColor" stroke-width="3"/><text x="180" y="78">−{dealt} HP</text><rect x="280" y="201" width="140" height="18" fill="none" stroke="currentColor"/><rect x="280" y="201" width="{}" height="18"/><text x="282" y="246">{health} / 40 HP</text>"#, f64::from(health) / 40.0 * 140.0));
        result.input = format!("power: {power}\narmor: 6\ndefending: {defending}");
        result.output = format!("damage = {dealt}\nremaining_health = {health}");
        result.metrics = vec![metric("Damage", dealt), metric("Remaining HP", health)]; result
    }).collect();
    Study {
        title: "A battle, one action at a time",
        intro: "Keep the target's armor fixed and compare the starting scene, an attack, and a defended attack.",
        method: "Rust calculates this original demonstration rule and draws the scene with original SVG pieces. The native Plume project implements the Rust/Bevy game rewrite.",
        scenes,
        sources: vec![],
        audio: None,
    }
}

fn rotated_triangle(angle: f64) -> [(f64, f64); 3] {
    let (sin, cos) = angle.to_radians().sin_cos();
    [(0.0, -90.0), (-80.0, 65.0), (80.0, 65.0)]
        .map(|(x, y)| (240.0 + x * cos - y * sin, 140.0 + x * sin + y * cos))
}

fn graphics() -> Study {
    let scenes = [0.0, 45.0, 90.0].into_iter().map(|angle| {
        let points = rotated_triangle(angle);
        let mut result = scene(format!("{angle}°"), "The same scene at a new angle", "Rotate each vertex around the center and the scene changes without changing its three-vertex structure. The renderer's job is to carry that scene to the platform.");
        result.svg = svg("A rotated triangle with a visible origin", &format!(r#"<path d="M40 140H440M240 20V260" stroke="currentColor" opacity=".2"/><polygon points="{}" opacity=".7"/><circle cx="240" cy="140" r="4"/>"#, points.iter().map(|(x,y)| format!("{x:.3},{y:.3}")).collect::<Vec<_>>().join(" ")));
        result.output = "Native graphics path: scene → Bevy → wgpu → platform backend\nBrowser example: Rust → SVG → browser".into();
        result.metrics = vec![metric("Rotation", format!("{angle}°")), metric("Vertices", 3), metric("View", "SVG study")]; result
    }).collect();
    Study {
        title: "Follow a triangle through the graphics layers",
        intro: "Change the rotation and compare the transformed vertices with the native renderer path.",
        method: "Rust calculates the triangle and draws it as SVG for this browser view. The next integration runs the scene through Bevy, wgpu, and the platform backend.",
        scenes,
        sources: vec![],
        audio: None,
    }
}

fn terminal() -> Study {
    #[derive(serde::Deserialize)]
    struct Frame {
        frame: usize,
        text: String,
    }
    let frames: Vec<Frame> = serde_json::from_str(include_str!(
        "../../content/experiment-fixtures/ttfx-sample-frames.json"
    ))
    .expect("The recorded terminal frames must be valid JSON");
    let scenes = frames.into_iter().map(|frame| {
        let mut result = scene(format!("Frame {}", frame.frame), "A native ttfx print-effect frame", "Text appears across a 24 × 3 canvas as the effect advances. These four stages come from the same native run with seed zero.");
        let drawing = frame.text.lines().enumerate().map(|(index,line)| format!(r#"<text x="35" y="{}" font-family="monospace" font-size="23" xml:space="preserve">{}</text>"#, 100 + index * 35, escape(line))).collect::<String>();
        result.svg = svg("A recorded print-effect frame", &drawing);
        result.input = "MAKE SMALL THINGS\nseed: 0\ncanvas: 24 × 3\neffect: print".into();
        result.output = frame.text;
        result.metrics = vec![metric("Selected frame", frame.frame), metric("Captured frames", 30)]; result
    }).collect();
    Study {
        title: "Follow the print effect frame by frame",
        intro: "Select four stages from the native Rust port and watch the text take shape.",
        method: "ttfx produced 30 frames in this recorded run. The page displays four of them. The next benchmark measures startup and frame throughput against TerminalTextEffects by ChrisBuilds.",
        scenes,
        sources: vec![source(
            "ttfx",
            "Upstream effect and engine",
            "TerminalTextEffects by ChrisBuilds supplies the effect design. ttfx ports it to Rust under the MIT license.",
            Some("https://github.com/ChrisBuilds/terminaltexteffects"),
        )],
        audio: None,
    }
}

#[derive(Clone, Copy)]
struct Rect {
    x: f64,
    y: f64,
    w: f64,
    h: f64,
}
impl Rect {
    fn area(self) -> f64 {
        self.w * self.h
    }
    fn intersection(self, other: Self) -> Option<Self> {
        let x = self.x.max(other.x);
        let y = self.y.max(other.y);
        let w = (self.x + self.w).min(other.x + other.w) - x;
        let h = (self.y + self.h).min(other.y + other.h) - y;
        (w > 0.0 && h > 0.0).then_some(Self { x, y, w, h })
    }
    fn drawing(self, opacity: f64) -> String {
        format!(
            r#"<rect x="{}" y="{}" width="{}" height="{}" opacity="{opacity}"/>"#,
            40.0 + self.x * 35.0,
            240.0 - (self.y + self.h) * 35.0,
            self.w * 35.0,
            self.h * 35.0
        )
    }
}

fn geometry() -> Study {
    let a = Rect {
        x: 1.0,
        y: 1.0,
        w: 4.0,
        h: 3.0,
    };
    let scenes = [("Overlap", 3.0), ("Touch", 5.0), ("Separate", 7.0)].into_iter().map(|(label, x)| {
        let b = Rect { x, y: 2.0, w: 3.0, h: 3.0 };
        let intersection = a.intersection(b);
        let area = intersection.map_or(0.0, Rect::area);
        let mut result = scene(label, "Two axis-aligned polygons", "The dark region is the area both rectangles share. Their union adds the two areas and subtracts that overlap once. A shared edge contributes zero area.");
        result.svg = svg("Two rectangles with their intersection highlighted", &format!("{}{}{}", a.drawing(0.25), b.drawing(0.4), intersection.map_or(String::new(), |r| r.drawing(1.0))));
        result.input = format!("A: origin (1, 1), size (4, 3)\nB: origin ({x}, 2), size (3, 3)");
        result.metrics = vec![metric("Intersection area", area), metric("Union area", a.area() + b.area() - area)]; result
    }).collect();
    Study {
        title: "See the shared region",
        intro: "Move the second rectangle from overlap to edge contact and then separation. Follow the change in intersection and union area.",
        method: "Rust calculates this independent example with axis-aligned rectangles. The next example connects a general polygon to Raygeo by Samuel Abels.",
        scenes,
        sources: vec![],
        audio: None,
    }
}

fn basketball() -> Study {
    let points = [14.0_f64, 20.0, 18.0, 24.0, 16.0];
    let mean = points.iter().sum::<f64>() / points.len() as f64;
    let deviation =
        (points.iter().map(|p| (p - mean).powi(2)).sum::<f64>() / points.len() as f64).sqrt();
    let scenes = [16.5, 18.5, 22.5].into_iter().map(|threshold| {
        let count = points.iter().filter(|value| **value > threshold).count();
        let mut result = scene(format!("Above {threshold}"), "Five synthetic games", "Keep the five scores fixed and move the threshold. The hit count changes with the line, while the mean and standard deviation stay the same. The fraction describes these five observations.");
        result.svg = svg("Points in five synthetic games", &points.iter().enumerate().map(|(i, points)| bar(&format!("Game {}", i + 1), *points, 30.0, 20 + i * 48)).collect::<String>());
        result.input = "Game points: 14, 20, 18, 24, 16".into();
        result.output = format!("{count} / 5 observations exceed {threshold}\nMean: {mean:.2}\nPopulation standard deviation: {deviation:.4}");
        result.metrics = vec![metric("Mean", format!("{mean:.1}")), metric("Above threshold", format!("{count} / 5")), metric("Standard deviation", format!("{deviation:.2}"))]; result
    }).collect();
    Study {
        title: "See what the threshold changes",
        intro: "Choose a points threshold and inspect the same five synthetic games, their mean, and their spread.",
        method: "Rust calculates the mean, population standard deviation, and observed threshold fraction from the synthetic scores. The next integration runs the sample through BookSharp's analysis path.",
        scenes,
        sources: vec![],
        audio: None,
    }
}

fn tokens(text: &str) -> Vec<String> {
    text.split(|c: char| !c.is_alphanumeric())
        .filter(|word| word.len() > 2)
        .map(str::to_lowercase)
        .filter(|word| {
            ![
                "the", "and", "what", "who", "does", "did", "was", "with", "from", "for", "will",
                "that", "this", "its", "are", "use", "how",
            ]
            .contains(&word.as_str())
        })
        .collect()
}

fn retrieve(query: &str, sources: &[Source]) -> Option<usize> {
    let query_tokens = tokens(query);
    sources
        .iter()
        .enumerate()
        .filter_map(|(index, source)| {
            let words = tokens(&source.text);
            let score = query_tokens
                .iter()
                .filter(|word| words.contains(word))
                .count();
            (score > 0).then_some((index, score))
        })
        .max_by(|a, b| a.1.cmp(&b.1).then_with(|| b.0.cmp(&a.0)))
        .map(|(index, _)| index)
}

fn retrieval(kind: &str) -> Study {
    let (title, intro, sources, queries, method, audio) = match kind {
        "thread" => (
            "Follow the answer back to the discussion",
            "Choose a question about the synthetic basketball thread, then inspect the comment or reply behind the answer.",
            vec![
                source(
                    "thread-1",
                    "Comment 1 — original sample",
                    "The team used a zone defense in the fourth quarter. This is a synthetic discussion.",
                    None,
                ),
                source(
                    "thread-2",
                    "Reply to comment 1 — original sample",
                    "The zone left the corner open. The shooter scored twice from that corner.",
                    None,
                ),
                source(
                    "thread-3",
                    "Comment 3 — original sample",
                    "The center collected four rebounds after halftime.",
                    None,
                ),
            ],
            [
                "What changed in the defense?",
                "What happened in the corner?",
                "What did the center do?",
                "Who won the championship?",
            ],
            "Rust retrieves excerpts by word overlap and links each answer to its source in the synthetic thread. The historical service uses the LangChain retrieval flow.",
            None,
        ),
        "document" => (
            "A terminal question with a source",
            "Choose a question over an original local project note.",
            vec![
                source(
                    "doc-1",
                    "Sample note — scope",
                    "The release includes a catalog and small Rust experiments. The first export uses static HTML.",
                    None,
                ),
                source(
                    "doc-2",
                    "Sample note — owner",
                    "Morgan owns the mobile layout review. The review deadline is Friday.",
                    None,
                ),
                source(
                    "doc-3",
                    "Sample note — publication",
                    "Public deployment requires approval after the local preview.",
                    None,
                ),
            ],
            [
                "What does the release include?",
                "Who owns the mobile review?",
                "What requires approval?",
                "What is the production password?",
            ],
            "Rust reads this fixed source index and retrieves an excerpt. The study has no Google Docs connection or model runtime.",
            None,
        ),
        "paper" => (
            "A paper excerpt with a visible citation",
            "Choose a question over a short excerpt from Attention Is All You Need.",
            vec![source(
                "paper-1",
                "Vaswani et al., 2017 — abstract excerpt",
                "We propose a new simple network architecture, the Transformer, based solely on attention mechanisms, dispensing with recurrence and convolutions entirely.",
                Some("https://arxiv.org/abs/1706.03762v7"),
            )],
            [
                "What architecture does the paper propose?",
                "What mechanisms form the model?",
                "Does it use recurrence?",
                "What is the model parameter count?",
            ],
            "Rust selects the cited excerpt. The authored answers paraphrase only that excerpt. The source quotation contains 20 words.",
            None,
        ),
        _ => (
            "Notes that point to the transcript",
            "Play an original synthetic speech sample, then inspect a transcript excerpt.",
            vec![
                source(
                    "audio-1",
                    "Transcript sentence 1 — original sample",
                    "The triangle demo is ready.",
                    None,
                ),
                source(
                    "audio-2",
                    "Transcript sentence 2 — original sample",
                    "Morgan will check the mobile layout on Friday.",
                    None,
                ),
                source(
                    "audio-3",
                    "Transcript sentence 3 — original sample",
                    "The file-transfer sample still needs a camera test.",
                    None,
                ),
            ],
            [
                "What demo is ready?",
                "Who will check the mobile layout?",
                "What needs a camera test?",
                "What was the final budget?",
            ],
            "macOS speech synthesis supplies the sample audio. The transcript is authored text. Rust retrieves excerpts. This page does not run speech recognition, Ollama, or Discord.",
            Some("/static/experiments/audio/sample.mp3"),
        ),
    };
    let scenes = queries.into_iter().enumerate().map(|(question, query)| {
        let mut result = scene(query, "The answer and its source", if kind == "paper" { "The authored answer paraphrases the matching excerpt. A question without a source match returns an explicit no-match result." } else if kind == "thread" { "The answer is the matching source text, with a link to its place in the discussion. A question without a match returns an explicit no-match result." } else { "The result returns the matching source text. A question with no matching source returns an explicit no-match result." });
        result.input = format!("$ sample-doc query {query:?}");
        if let Some(index) = retrieve(query, &sources) {
            result.output = if kind == "paper" { ["Proposal: the Transformer.", "Method: attention alone.", "The abstract states that the design removes recurrence and convolution."][question].into() } else { sources[index].text.clone() };
            result.citations.push(sources[index].key.clone());
            result.metrics = vec![metric("Source", &sources[index].title), metric("Answer type", if kind == "paper" { "Authored paraphrase" } else { "Excerpt" })];
        } else { result.output = "No source match. This example cannot answer the question.".into(); }
        result
    }).collect();
    Study {
        title,
        intro,
        method,
        scenes,
        sources,
        audio,
    }
}

#[derive(Clone)]
struct Item {
    name: &'static str,
    parent: Option<usize>,
}

fn location(items: &[Item], item: usize) -> Vec<&'static str> {
    let mut path = Vec::new();
    let mut next = Some(item);
    while let Some(index) = next {
        assert!(
            path.len() < items.len(),
            "The inventory hierarchy must have no cycle"
        );
        path.push(items[index].name);
        next = items[index].parent;
    }
    path.reverse();
    path
}

fn move_item(items: &mut [Item], item: usize, destination: usize) -> bool {
    if item >= items.len() || destination >= items.len() {
        return false;
    }
    let mut next = Some(destination);
    while let Some(index) = next {
        if index == item {
            return false;
        }
        next = items[index].parent;
    }
    items[item].parent = Some(destination);
    true
}

fn inventory() -> Study {
    let items = vec![
        Item {
            name: "Imaginary home",
            parent: None,
        },
        Item {
            name: "Studio",
            parent: Some(0),
        },
        Item {
            name: "Desk drawer",
            parent: Some(1),
        },
        Item {
            name: "Shelf box",
            parent: Some(1),
        },
        Item {
            name: "Camera",
            parent: Some(2),
        },
    ];
    let scenes = [("Find", 2), ("Move to shelf", 3), ("Return to drawer", 2)].into_iter().map(|(label, destination)| {
        let mut state = items.clone(); assert!(move_item(&mut state, 4, destination));
        let path = location(&state, 4).join(" → ");
        let mut result = scene(label, "The camera keeps a complete location", "The object points to its container. The location follows each parent to the room and home.");
        result.svg = svg("A camera belongs to either the desk drawer or shelf box", &format!(r#"<rect x="25" y="25" width="430" height="220" fill="none" stroke="currentColor"/><text x="45" y="57">Studio</text><rect x="50" y="85" width="150" height="120" opacity=".15"/><rect x="275" y="85" width="150" height="120" opacity=".15"/><text x="65" y="115">Desk drawer</text><text x="293" y="115">Shelf box</text><rect x="{}" y="143" width="75" height="42" rx="4"/><circle cx="{}" cy="164" r="13" fill="white" opacity=".65"/>"#, if destination == 2 { 85 } else { 312 }, if destination == 2 { 124 } else { 351 }));
        result.output = path;
        result.metrics = vec![metric("Object", "Camera"), metric("Container", state[destination].name), metric("Objects after move", state.len())]; result
    }).collect();
    Study {
        title: "Find an object, then move it",
        intro: "Move the camera between two containers in an imaginary room.",
        method: "Rust calculates each fixed move from the same baseline. The hierarchy rejects a move into the object's own descendants. This is a new study of the earlier inventory idea.",
        scenes,
        sources: vec![],
        audio: None,
    }
}

fn binomial_cdf(n: u32, k: u32) -> f64 {
    let mut coefficient = 1_u64;
    let mut sum = 0_u64;
    for i in 0..=k.min(n) {
        if i > 0 {
            coefficient = coefficient * u64::from(n - i + 1) / u64::from(i);
        }
        sum += coefficient;
    }
    sum as f64 / 2_f64.powi(n as i32)
}

fn numerical() -> Study {
    let scenes = [0, 2, 5].into_iter().map(|k| {
        let value = binomial_cdf(5, k);
        let mut result = scene(format!("At most {k}"), "An exact finite CDF", "Five fair coin flips have 32 equally likely outcomes. The result sums the binomial coefficients up to the selected count.");
        result.svg = svg("The six counts in five fair coin flips", &(0..=5).map(|i| {
            let mass = binomial_cdf(5, i) - if i == 0 { 0.0 } else { binomial_cdf(5, i - 1) };
            format!(r#"<rect x="{}" y="{}" width="45" height="{}" opacity="{}"/><text x="{}" y="250">{i}</text>"#, 40 + i * 70, 230.0 - mass * 550.0, mass * 550.0, if i <= k { 1.0 } else { 0.2 }, 58 + i * 70)
        }).collect::<String>());
        result.input = format!("n = 5\np = 1/2\nk = {k}");
        result.output = format!("P(X ≤ {k}) = {value:.5}\n{} / 32 possible outcomes", (value * 32.0) as u32);
        result.metrics = vec![metric("CDF", format!("{value:.5}")), metric("Reference", "32 enumerated outcomes")]; result
    }).collect();
    Study {
        title: "A routine with a finite reference",
        intro: "Change the count and inspect the cumulative mass.",
        method: "Rust computes this independent binomial example with exact integer coefficients. The example does not claim to port the historical Fortran genetics routine.",
        scenes,
        sources: vec![],
        audio: None,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn corrected_ld_scores_keep_perfect_pairs_and_allow_negative_contributions() {
        let columns = [
            [0., 0., 1., 1., 2., 2.],
            [0., 1., 0., 2., 1., 2.],
            [2., 2., 1., 1., 0., 0.],
        ];
        assert!((correlation(&columns[0], &columns[2]) + 1.0).abs() < 1e-12);
        let raw = ld_scores(&columns, false, false);
        let corrected = ld_scores(&columns, true, false);
        assert!((raw[0] - 2.25).abs() < 1e-12);
        assert!((corrected[0] - 2.0625).abs() < 1e-12);
        assert!(ld_scores(&columns, true, true)[0] < corrected[0]);
    }

    #[test]
    fn stale_or_invalid_metrics_never_become_current_zeroes() {
        assert_eq!(measurement_state(None, Some(0)), MeasurementState::Missing);
        assert_eq!(
            measurement_state(Some(f64::NAN), Some(0)),
            MeasurementState::Missing
        );
        assert_eq!(
            measurement_state(Some(101.0), Some(0)),
            MeasurementState::Missing
        );
        assert_eq!(
            measurement_state(Some(0.0), Some(60)),
            MeasurementState::Current
        );
        assert_eq!(
            measurement_state(Some(0.0), Some(61)),
            MeasurementState::Stale
        );
    }

    #[test]
    fn geometry_distinguishes_overlap_edge_and_empty_region() {
        let a = Rect {
            x: 1.,
            y: 1.,
            w: 4.,
            h: 3.,
        };
        let b = Rect {
            x: 3.,
            y: 2.,
            w: 3.,
            h: 3.,
        };
        assert_eq!(a.intersection(b).unwrap().area(), 4.0);
        assert!(a.intersection(Rect { x: 5., ..b }).is_none());
        assert!(a.intersection(Rect { x: 7., ..b }).is_none());
    }

    #[test]
    fn inventory_moves_preserve_identity_and_reject_cycles() {
        let mut items = vec![
            Item {
                name: "Home",
                parent: None,
            },
            Item {
                name: "Box",
                parent: Some(0),
            },
            Item {
                name: "Camera",
                parent: Some(1),
            },
        ];
        assert!(!move_item(&mut items, 0, 2));
        assert!(!move_item(&mut items, 1, 1));
        assert!(!move_item(&mut items, 2, 99));
        assert!(move_item(&mut items, 2, 0));
        assert_eq!(location(&items, 2), vec!["Home", "Camera"]);
        assert_eq!(items.len(), 3);
    }

    #[test]
    fn binomial_matches_an_independent_complete_enumeration() {
        for k in 0..=5 {
            let count = (0_u32..32).filter(|bits| bits.count_ones() <= k).count();
            assert_eq!(binomial_cdf(5, k), count as f64 / 32.0);
        }
        assert_eq!(binomial_cdf(5, 99), 1.0);
    }

    #[test]
    fn retrieval_has_stable_ties_and_an_explicit_no_match() {
        let sources = vec![
            source("first", "First", "mobile review Friday", None),
            source("second", "Second", "mobile review Thursday", None),
        ];
        assert_eq!(retrieve("mobile review", &sources), Some(0));
        assert_eq!(retrieve("Friday?", &sources), Some(0));
        assert_eq!(retrieve("production password", &sources), None);
        assert_eq!(escape("<script>&\""), "&lt;script&gt;&amp;&quot;");
    }

    #[test]
    fn battle_defense_and_rotation_preserve_their_contracts() {
        assert_eq!(damage(18, 6, false), 12);
        assert_eq!(damage(18, 6, true), 6);
        assert_eq!(damage(3, 6, false), 0);
        for angle in [0.0, 45.0, 90.0] {
            let points = rotated_triangle(angle);
            let radius = ((points[0].0 - 240.0).powi(2) + (points[0].1 - 140.0).powi(2)).sqrt();
            assert!((radius - 90.0).abs() < 1e-10);
        }
    }
}
