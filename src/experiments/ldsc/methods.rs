//! Small computational diagrams. These are schematics, not benchmark measurements.
use plotters::{coord::Shift, prelude::*};

type Canvas<'a> = DrawingArea<SVGBackend<'a>, Shift>;
type DrawResult = Result<(), DrawingAreaErrorKind<std::io::Error>>;

const INK: RGBColor = RGBColor(39, 49, 60);
const BLUE: RGBColor = RGBColor(50, 75, 148);
const GREEN: RGBColor = RGBColor(49, 103, 92);
const PALE: RGBColor = RGBColor(233, 238, 246);
const RULE: RGBColor = RGBColor(211, 220, 231);
const BUCKETS: [usize; 6] = [0, 1, 2, 0, 1, 2];
const SIGNS: [f64; 6] = [1.0, -1.0, 1.0, -1.0, 1.0, -1.0];

pub(crate) struct Methods {
    pub(crate) windows: Vec<Window>,
    pub(crate) precision_svg: String,
    pub(crate) sketch_svg: String,
    pub(crate) chunk_f64_mib: String,
    pub(crate) chunk_f32_mib: String,
}

pub(crate) struct Window {
    pub(crate) index: usize,
    pub(crate) label: String,
    pub(crate) description: String,
    pub(crate) svg: String,
}

fn text(canvas: &Canvas<'_>, value: &str, at: (i32, i32), color: RGBColor) -> DrawResult {
    canvas.draw(&Text::new(
        value,
        at,
        ("sans-serif", 15).into_font().color(&color),
    ))
}

fn rectangle(canvas: &Canvas<'_>, from: (i32, i32), to: (i32, i32), color: RGBColor) -> DrawResult {
    canvas.draw(&Rectangle::new([from, to], color.filled()))
}

fn diagram(title: &str, height: u32, draw: impl FnOnce(&Canvas<'_>) -> DrawResult) -> String {
    let mut output = String::new();
    {
        let canvas = SVGBackend::with_string(&mut output, (360, height)).into_drawing_area();
        draw(&canvas).expect("Valid LDSC diagram geometry");
        canvas.present().expect("Complete LDSC SVG diagram");
    }
    // The library emits presentation attributes, which the site's strict CSP permits.
    output = output.replacen(
        "<svg ",
        &format!("<svg class=\"ldsc-method-svg\" role=\"img\" viewBox=\"0 0 360 {height}\" "),
        1,
    );
    let root_end = output.find('>').expect("SVG opening element");
    output.insert_str(root_end + 1, &format!("<title>{title}</title>"));
    output
}

fn window(start: usize, index: usize) -> Window {
    let retained = start - 3;
    let end = start + 2;
    let svg = diagram(
        "Two new variants share three retained variants in blocked matrix products",
        360,
        |canvas| {
            text(canvas, "Variant columns", (61, 8), INK)?;
            for variant in 0..12 {
                let x = 62 + variant as i32 * 23;
                text(canvas, &(variant + 1).to_string(), (x + 3, 32), INK)?;
                let color = if (start..end).contains(&variant) {
                    BLUE
                } else if (retained..start).contains(&variant) {
                    GREEN
                } else {
                    PALE
                };
                rectangle(canvas, (x, 51), (x + 21, 62), color)?;
                text(
                    canvas,
                    &(variant + 1).to_string(),
                    (35, 76 + variant as i32 * 20),
                    INK,
                )?;
                for other in 0..12 {
                    let within = (start..end).contains(&variant) && (start..end).contains(&other);
                    let cross = ((retained..start).contains(&variant)
                        && (start..end).contains(&other))
                        || ((retained..start).contains(&other) && (start..end).contains(&variant));
                    let color = if within {
                        BLUE
                    } else if cross {
                        GREEN
                    } else {
                        PALE
                    };
                    let cell_x = 62 + other as i32 * 23;
                    let cell_y = 73 + variant as i32 * 20;
                    rectangle(canvas, (cell_x, cell_y), (cell_x + 21, cell_y + 18), color)?;
                }
            }
            text(canvas, "Rows: variants", (35, 328), INK)?;
            Ok(())
        },
    );
    Window {
        index,
        label: format!("Chunk {}", index + 1),
        description: format!(
            "A keeps variants {}–{}. B contains variants {}–{}. Advance the chunk to reuse the overlapping columns.",
            retained + 1,
            start,
            start + 1,
            end
        ),
        svg,
    }
}

fn precision() -> String {
    diagram(
        "One normalized genotype occupies eight bytes in f64 and four bytes in f32",
        248,
        |canvas| {
            text(canvas, "One normalized value", (12, 12), INK)?;
            for (y, label, bytes, color) in [(59, "f64", 8, INK), (139, "f32", 4, BLUE)] {
                text(canvas, label, (12, y), color)?;
                for byte in 0..8 {
                    rectangle(
                        canvas,
                        (12 + byte * 41, y + 27),
                        (49 + byte * 41, y + 59),
                        if byte < bytes { color } else { PALE },
                    )?;
                }
                text(canvas, &format!("{bytes} bytes per value"), (90, y), INK)?;
            }
            text(
                canvas,
                "Same matrix shape. Half the genotype bytes.",
                (12, 219),
                INK,
            )?;
            Ok(())
        },
    )
}

/// An illustrative signed hash, independent of the engine's seeded assignment.
fn sketch_values() -> ([f64; 6], [f64; 3], [f64; 3]) {
    let scale = (1.5_f64).sqrt();
    let input = [-scale, -scale, 0.0, 0.0, scale, scale];
    let mut projected = [0.0; 3];
    for i in 0..input.len() {
        projected[BUCKETS[i]] += SIGNS[i] * input[i];
    }
    let norm_sq: f64 = projected.iter().map(|x| x * x).sum();
    let renormalized = projected.map(|x| x * (input.len() as f64 / norm_sq).sqrt());
    (input, projected, renormalized)
}

fn sketch() -> String {
    let (input, projected, renormalized) = sketch_values();
    let norm_sq: f64 = renormalized.iter().map(|x| x * x).sum();
    let result = format!(
        "Result: {:+.0}, {:+.0}, {:+.0}. Squared norm: {norm_sq:.0}.",
        renormalized[0], renormalized[1], renormalized[2]
    );
    diagram(
        "Six normalized sample rows scatter with random signs into three buckets, then rescale",
        354,
        |canvas| {
            text(canvas, "6 sample rows", (12, 10), INK)?;
            text(canvas, "3 bucket rows", (228, 10), BLUE)?;
            for (i, value) in input.iter().enumerate() {
                let y = 49 + i as i32 * 37;
                let target_y = 74 + BUCKETS[i] as i32 * 74;
                canvas.draw(&PathElement::new(
                    vec![(103, y + 12), (231, target_y + 14)],
                    RULE.stroke_width(2),
                ))?;
                rectangle(canvas, (12, y), (101, y + 29), PALE)?;
                text(canvas, &format!("{value:+.2}"), (25, y + 4), INK)?;
                text(
                    canvas,
                    if SIGNS[i] > 0.0 { "+" } else { "−" },
                    (111, y + 4),
                    GREEN,
                )?;
            }
            for (i, value) in projected.iter().enumerate() {
                let y = 74 + i as i32 * 74;
                rectangle(canvas, (232, y), (346, y + 32), PALE)?;
                text(canvas, &format!("{value:+.2}"), (251, y + 6), BLUE)?;
            }
            text(
                canvas,
                "Rescale each column to squared norm N.",
                (12, 296),
                INK,
            )?;
            text(canvas, &result, (12, 327), BLUE)?;
            Ok(())
        },
    )
}

pub(crate) fn build(samples: usize) -> Methods {
    let chunk_values = samples * 200;
    let mib = 1024.0 * 1024.0;
    Methods {
        windows: [4, 6, 8]
            .into_iter()
            .enumerate()
            .map(|(i, start)| window(start, i))
            .collect(),
        precision_svg: precision(),
        sketch_svg: sketch(),
        chunk_f64_mib: format!("{:.2}", chunk_values as f64 * 8.0 / mib),
        chunk_f32_mib: format!("{:.2}", chunk_values as f64 * 4.0 / mib),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn signed_projection_preserves_the_displayed_rescaled_norm() {
        let (input, projected, renormalized) = sketch_values();
        assert!((input.iter().map(|x| x * x).sum::<f64>() - 6.0).abs() < 1e-12);
        assert!((projected[1] - 6.0_f64.sqrt()).abs() < 1e-12);
        assert!((renormalized[0] + 1.0).abs() < 1e-12);
        assert!((renormalized[1] - 2.0).abs() < 1e-12);
        assert!((renormalized.iter().map(|x| x * x).sum::<f64>() - 6.0).abs() < 1e-12);
    }
}
