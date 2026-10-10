# Native experiment fixtures

The result manifest records the observed local fixture results on October 9, 2026.
The source checkouts can contain unrelated work. The recorded hashes describe the selected snapshot.
The commands below use task-specific build directories outside each source checkout.

## Wedeo

The original input is a synthetic 32 × 32 test pattern with three baseline H.264 intra frames.
FFmpeg 8.1.2 supplies the encoder and reference decoder.
The native Rust Wedeo CLI supplies the compared decode.

```sh
cargo build --locked --jobs 1 -p wedeo-cli --target-dir /tmp/portfolia-demo-build/wedeo
ffmpeg -f lavfi -i testsrc=size=32x32:rate=1 -frames:v 3 -pix_fmt yuv420p -c:v libx264 -profile:v baseline -g 1 -f h264 pattern.h264
wedeo-cli -i pattern.h264 -bitexact -c:v rawvideo -f framecrc -
ffmpeg -i pattern.h264 -bitexact -c:v rawvideo -f framecrc -
```

Run the build command from the Wedeo checkout.
Use the new binary for the decode command.
The fixture files retain both checksum outputs.
A separate rawvideo comparison confirms equal bytes.
The PNG files present the Wedeo YUV output through an FFmpeg display conversion.
Wedeo retains FFmpeg source credit and its LGPL-2.1-or-later license.

## Volt

The original text fixture contains 32 bytes.
The native Rust CLI produces three QR frames and recovers the exact file from one accepted frame.

```sh
cargo build --locked --jobs 1 --target-dir /tmp/portfolia-demo-build/volt
volt encode volt-message.txt --out ./frames
volt decode ./frames --out ./recovered.txt
cmp volt-message.txt recovered.txt
```

Run the build command from the Volt checkout.
Use the new binary for the encode and decode commands.
The result manifest retains the recovered digest.
This record uses generated PNGs. It supplies no live camera result.

## Tylax

The native converter receives three original LaTeX documents with amsmath.
It produces actual Typst output with a degraded artifact grade.
The unsupported-package diagnostic remains visible on the page.

```sh
cargo build --locked --offline --jobs 1 --features cli --bin t2l --target-dir /tmp/portfolia-demo-build/tylax
t2l equation.tex --direction l2t --no-preamble --output equation.typ
typst compile equation-preview.typ equation.svg
```

Run the build command from the Tylax checkout.
Use the new binary for conversion.
Repeat the conversion for the matrix and sum fixtures.

The preview compiler is Typst 0.15.1. It is not the converter's target-version fidelity gate.
SciPenAI authors the upstream Apache-2.0 converter.
The original math fixtures do not claim an attributed upstream code contribution.

## Rustlyn

The current binder fixture checks an unresolved value, its owner expression, and its assigned byte range.
The illustrated C# line matches the assigned range. The fixture itself constructs the expression.

```sh
rtk cargo test -p rustlyn-bind --offline --jobs 1 --target-dir /tmp/portfolia-demo-build/rustlyn records_unresolved_name_diagnostic_with_source_range
```

Run the command from the Rustlyn checkout.
The command runs one test and filters 519 others.
A command with an unqualified name and `--exact` runs zero tests. That preliminary run is not evidence.

## Terminal effect

The native ttfx print effect uses an original text sample and seed zero.
The output contains length-prefixed frames with a newline separator after each frame.
The complete record contains 30 frames.
The JSON fixture keeps four selected frames for the page.

```sh
cargo build --locked --jobs 1 --target-dir /tmp/portfolia-demo-build/ttfx
ttfx --input-file ttfx-input.txt --seed 0 --parity-dump --max-frames 120 --canvas-width 24 --canvas-height 3 --ignore-terminal-dimensions --no-color print
```

Run the build command from the ttfx checkout.
Use the new binary for the frame command.
ChrisBuilds authors TerminalTextEffects and its effect engine.
The Rust port preserves the upstream MIT credit.
No performance comparison enters this fixture.

## Compiler examples

Rust and Swift compile independent add-one programs for the same four inputs.
Their native outputs agree.
The MIR and SIL files come from their respective compilers.
No translation connects those intermediate forms.

The installed cargo-dotnet SDK also compiles the Rust fixture to a managed .NET 10 assembly.
The fixture enables release overflow checks.
It uses `#[inline(never)]` on the addition function.
Its output equals the native Rust result.

```sh
cargo dotnet restore ./fixture
cargo dotnet run ./fixture --offline
```

The restore receipt covers the current fixture inputs.
A manifest change requires a new restore receipt before an offline run.
The installed SDK is version 0.0.1 and uses nightly-2026-06-17.
It differs from the newer rustc_codegen_clr source checkout.

The backend reports unresolved runtime stubs. The selected four-input program still runs successfully.
This result establishes no general compatibility.
FractalFir authors the upstream backend.

## Original media and fixed sources

The speech sample contains original authored text and macOS synthesized speech.
Its transcript is authored text, not speech-recognition output.
The discussion, document, and claim fixtures contain original synthetic text.
No private participants, messages, documents, or recordings enter these samples.
The paper page quotes 20 words from the abstract of Attention Is All You Need and links to the original source.
