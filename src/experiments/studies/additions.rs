use super::*;

pub(super) fn build(slug: &str) -> Option<Study> {
    Some(match slug {
        "tessera" => tessera(),
        "rowla" => rowla(),
        "rust-target-size" => rust_target_size(),
        _ => return None,
    })
}

fn tessera() -> Study {
    let scenes = [
        (
            "Tree + pixels",
            "Semantic state commits in the same transaction as pixels",
            "Every window writes its semantic tree (roles, names, actions, bounds) inside the exact transaction that commits its pixels. Agents act by node identity—never guessing pixel coordinates—wait on an explicit settled signal, and never see server-blanked sensitive fields.",
            "tx.commit(rev = 43):\n  pixels: shm_handle(720x900)\n  node[41]: Button(\"Submit\", enabled)\n  node[42]: Password(sensitive = true)",
            "MCP read_tree():\n  node[41] Button \"Submit\" [actable]\n  node[42] Password [REDACTED]\ncapture(): node[42] blanked by server\nstate: SETTLED",
            "Atomic",
            r#"<rect x="155" y="22" width="170" height="44" rx="5" fill="none" stroke="currentColor" stroke-width="2"/><text x="240" y="49" text-anchor="middle">Transaction #43</text><path d="M240 66v26M120 92h240M120 92v26M360 92v26" fill="none" stroke="currentColor" stroke-width="1.8"/><rect x="40" y="118" width="160" height="54" rx="5" fill="none" stroke="currentColor" stroke-width="2"/><text x="120" y="142" text-anchor="middle">Pixels (SHM)</text><text x="120" y="160" text-anchor="middle" font-size="12" opacity=".72">password blanked</text><rect x="280" y="118" width="160" height="54" rx="5" fill="none" stroke="currentColor" stroke-width="2"/><text x="360" y="142" text-anchor="middle">Semantic Tree</text><text x="360" y="160" text-anchor="middle" font-size="12" opacity=".72">node 41 · settled</text><rect x="105" y="206" width="270" height="44" rx="6" fill="currentColor" opacity=".88"/><text x="240" y="233" text-anchor="middle" fill="white" font-size="14">Zero frame/label skew · MCP ready</text>"#,
        ),
        (
            "Multi-agent locks",
            "Several agents working on one window without fighting over focus",
            "Tessera treats a window's semantic tree like a concurrent data structure. Agents acquire disjoint subtree grants and deadlock-free FIFO locks, each with its own input seat—so Agent A fills a form while Agent B edits a table in the same window.",
            "Agent A: lock(subtree = /form/address, seat = 1)\nAgent B: lock(subtree = /sheet/rows,  seat = 2)",
            "Agent A → GRANTED (exclusive /form/address)\nAgent B → GRANTED (exclusive /sheet/rows)\ndeadlock_possible: false (whole-grant FIFO)\ncursor_conflict: none (per-seat focus)",
            "Parallel",
            r#"<rect x="145" y="22" width="190" height="44" rx="5" fill="none" stroke="currentColor" stroke-width="2"/><text x="240" y="49" text-anchor="middle">Shared Window Tree</text><path d="M240 66v26M120 92h240M120 92v26M360 92v26" fill="none" stroke="currentColor" stroke-width="1.8"/><rect x="40" y="118" width="160" height="54" rx="5" fill="currentColor" opacity=".12" stroke="currentColor" stroke-width="2"/><text x="120" y="142" text-anchor="middle">Agent A · Seat 1</text><text x="120" y="160" text-anchor="middle" font-size="12" opacity=".78">lock: /form/address</text><rect x="280" y="118" width="160" height="54" rx="5" fill="currentColor" opacity=".12" stroke="currentColor" stroke-width="2"/><text x="360" y="142" text-anchor="middle">Agent B · Seat 2</text><text x="360" y="160" text-anchor="middle" font-size="12" opacity=".78">lock: /sheet/rows</text><rect x="105" y="206" width="270" height="44" rx="6" fill="currentColor" opacity=".88"/><text x="240" y="233" text-anchor="middle" fill="white" font-size="14">Two seats · Disjoint subtrees</text>"#,
        ),
        (
            "Optimistic CAS",
            "Stale actions are refused before they ever reach the app",
            "Every action stamps the tree clock the agent read. If the target node—or any node in its declared reads set—changed since that stamp, the server refuses the action immediately so an agent never clicks a stale button.",
            "act(node = 41, expected_clock = 18)\nserver_clock(node 41): 19 (price updated)",
            "status: REFUSED (StaleClock)\napp_notified: false\nnext: agent reads delta(18 → 19) and re-decides",
            "CAS Guard",
            r#"<rect x="40" y="88" width="150" height="68" rx="5" fill="none" stroke="currentColor" stroke-width="2"/><text x="115" y="118" text-anchor="middle">Agent act()</text><text x="115" y="140" text-anchor="middle" font-size="12" opacity=".72">clock = 18</text><path d="M190 122h50" stroke="currentColor" stroke-width="2"/><rect x="240" y="88" width="200" height="68" rx="5" fill="currentColor" opacity=".85"/><text x="340" y="118" text-anchor="middle" fill="white">Server Clock = 19</text><text x="340" y="140" text-anchor="middle" fill="white" font-size="12" opacity=".9">Refused before app</text><text x="240" y="212" text-anchor="middle" font-size="13" opacity=".75">Compare-and-swap on UI state eliminates race clicks</text>"#,
        ),
        (
            "Single-writer",
            "One owner per property, capability grants for everything else",
            "Apps own content; the window manager owns placement. Neither can clobber the other, and a read-only agent cannot mutate properties it holds no write capability for. Revoking a grant destroys its node and takes effect on the next frame.",
            "WM writes:    node/editor/bounds = rect(0, 0, 720, 900)\nAgent writes: node/editor/title  = \"hacked\"",
            "WM    → COMMITTED (holds placement capability)\nAgent → REJECTED  (CapabilityDenied)\nunsafe_outside_ipc: 0",
            "Isolated",
            r#"<rect x="165" y="22" width="150" height="44" rx="5" fill="none" stroke="currentColor" stroke-width="2"/><text x="240" y="49" text-anchor="middle">Root tree</text><path d="M240 66v28M120 94h240M120 94v26M360 94v26" fill="none" stroke="currentColor" stroke-width="1.8"/><rect x="45" y="120" width="150" height="52" rx="5" fill="none" stroke="currentColor" stroke-width="2"/><text x="120" y="143" text-anchor="middle">Editor node</text><text x="120" y="162" text-anchor="middle" font-size="12" opacity=".75">owner: App + WM</text><rect x="285" y="120" width="150" height="52" rx="5" fill="none" stroke="currentColor" stroke-width="2"/><text x="360" y="143" text-anchor="middle">Agent grant</text><text x="360" y="162" text-anchor="middle" font-size="12" opacity=".75">read + act only</text><rect x="115" y="206" width="250" height="44" rx="6" fill="currentColor" opacity=".88"/><text x="240" y="233" text-anchor="middle" fill="white" font-size="14">Write denied · Grant enforced</text>"#,
        ),
    ]
    .into_iter()
    .map(|(label, title, explanation, input, output, mode, drawing)| {
        let mut result = scene(label, title, explanation);
        result.input = input.into();
        result.output = output.into();
        result.metrics = vec![
            metric("Mechanism", mode),
            metric("Architecture", "18 Rust crates"),
            metric("Agent interface", "Native MCP"),
        ];
        result.svg = svg("Tessera protocol architecture diagram", drawing);
        result
    })
    .collect();
    Study {
        title: "Inside the Tessera protocol",
        intro: "Walk through the four protocol primitives that turn a desktop session into a clean, concurrent, typed environment for AI agents.",
        method: "All four primitives—atomic semantic commits, subtree grants with deadlock-free FIFO locks, clock-stamped CAS actions, and single-writer capability checks—are implemented and tested across the 18-crate Rust workspace.",
        scenes,
        sources: vec![],
        audio: None,
    }
}

fn rowla() -> Study {
    let scenes = [
        (
            "Window buttons",
            "One dedicated button per window",
            "Every open window gets its own button along the screen edge with cached ScreenCaptureKit hover previews and instant ⌘W / ⌘Q controls—no more hunting through macOS app groupings.",
            "/static/experiments/rowla/taskbar.png",
            "windows: Arc — GitHub PRs · Zed — main.rs · Ghostty — cargo test · Notes — Roadmap\ncache_cap: 16 MiB / 32 thumbnails",
            "Hovering Ghostty shows the live cached preview with direct close (⌘W) and quit (⌘Q) actions.",
            "Per-window strip",
        ),
        (
            "One-click Sort",
            "Reset a busy strip to your preferred order",
            "Clicking Sort restores your configured app order (Arc → Zed → Ghostty) while keeping main windows ahead of utility popups inside each application.",
            "/static/experiments/rowla/sort.png",
            "action: Sort button (or macOS Shortcut / Spotlight)\npreferred_order: [Arc, Zed, Ghostty]",
            "Taskbar snaps cleanly back into your configured order in one click.",
            "Instant Sort",
        ),
        (
            "Native tab bubbles",
            "Utility windows and native tabs stay compact",
            "Related utility windows and native macOS tabs appear as compact numbered bubbles attached directly to their parent window tile instead of cluttering the bar.",
            "/static/experiments/rowla/tabs.png",
            "window: Ghostty — tessera\nnative_tabs: [1: tessera, 2: cargo clippy, 3: git log]",
            "Three Ghostty tabs sit cleanly inside one predictable tile.",
            "Tab bubbles",
        ),
        (
            "Stable tile position",
            "Switch tabs without shuffling the taskbar",
            "Moving between native tabs keeps the parent window tile anchored in the exact same slot so muscle memory stays intact.",
            "/static/experiments/rowla/stable-tile.png",
            "switch: Tab 1 (tessera) → Tab 2 (cargo clippy)\ntile_slot: unchanged",
            "Tab 2 activates cleanly with zero bar reshuffling.",
            "Zero jitter",
        ),
    ]
    .into_iter()
    .map(|(label, title, explanation, img, input, output, feature)| {
        let mut result = scene(label, title, explanation);
        result.image = Some(StudyImage {
            src: img.into(),
            width: 1280,
            height: 720,
        });
        result.input = input.into();
        result.output = output.into();
        result.metrics = vec![
            metric("Feature", feature),
            metric("Release", "Signed & notarized"),
            metric("Platform", "macOS 15.2+ ARM64"),
        ];
        result
    })
    .collect();
    Study {
        title: "Rowla in action",
        intro: "Inspect the shipped native Rust macOS taskbar across hover previews, one-click Sort, native tab bubbles, and stable tile positioning.",
        method: "Shipped as a free, MIT-licensed, Developer ID signed and Apple-notarized macOS beta on GitHub.",
        scenes,
        sources: vec![
            source(
                "rowla-repo",
                "Rowla on GitHub (MIT)",
                "Free, open-source Windows-style taskbar for macOS written in native Rust.",
                Some("https://github.com/sharifhsn/rowla"),
            ),
            source(
                "rowla-release",
                "Download Apple Silicon Beta (v0.2.0-beta.3)",
                "Developer ID signed and Apple-notarized macOS 15.2+ release.",
                Some("https://github.com/sharifhsn/rowla/releases/tag/v0.2.0-beta.3"),
            ),
        ],
        audio: None,
    }
}

fn rust_target_size() -> Study {
    let scenes = [
        (
            "Bevy (6 configs)",
            "Cargo retention: 100.48 GiB → 34.62 GiB (65.5% saved)",
            "Across six Bevy configurations with full debug info and incremental compilation, active retention reclaimed 65.86 GiB while keeping 100% warm-build artifact reuse.",
            "project: bevy (6 configurations)\nordinary_target: 100.48 GiB\nactive_target: 34.62 GiB",
            "saved: 65.5% (65.86 GiB reclaimed)\nfirst_return: 31.97 s → 263.32 s\nwarm_reuse: 100% (check/build/test/clippy)",
            100.48_f64,
            34.62_f64,
            "65.5%",
        ),
        (
            "Polars (compact Wild)",
            "Compact rustc + Wild: 8.15 GiB → 1.49 GiB (81.7% saved)",
            "Compressing objects and metadata, content-addressing ELF files, linking compact libraries directly in Wild, and rebuilding dep-graph indices in memory shrank Polars's target/ by 81.7%.",
            "project: polars (full debug + incremental)\nordinary_target: 8.145 GiB\ncompact_target: 1.489 GiB",
            "saved: 81.7% (6.656 GiB reclaimed)\ndebug_info: Zstd DWARF (gdb-readable .dwo)\narchive_expansion_at_link: eliminated",
            8.145,
            1.489,
            "81.7%",
        ),
        (
            "Ruff & uv (Astral)",
            "Cargo retention on Ruff (61.6%) and uv (61.1%)",
            "Running 201 commands and 26 exact runtime oracles across Ruff and uv cut target/ from 14.70 → 5.64 GiB on Ruff and 28.55 → 11.11 GiB on uv.",
            "ruff: 14.70 GiB → 5.64 GiB (3 configs)\nuv:   28.55 GiB → 11.11 GiB (3 configs)",
            "ruff_saved: 61.6% | first_return: 5.07 → 61.72 s\nuv_saved:   61.1% | first_return: 6.33 → 123.93 s\nwarm_reuse: 100% across both workspaces",
            28.55,
            11.11,
            "61.1%",
        ),
    ]
    .into_iter()
    .map(|(label, title, explanation, input, output, before, after, saved)| {
        let mut result = scene(label, title, explanation);
        result.input = input.into();
        result.output = output.into();
        result.metrics = vec![
            metric("Ordinary", format!("{before:.2} GiB")),
            metric("Prototype", format!("{after:.2} GiB")),
            metric("Saved", saved),
        ];
        result.svg = svg(
            "Rust target directory size comparison in GiB",
            &format!(
                r#"<text x="20" y="42" font-size="14" font-weight="600">{}</text>{}{}"#,
                escape(title),
                bar("Ordinary GiB", before, before * 1.05, 86),
                bar("Prototype GiB", after, before * 1.05, 166)
            ),
        );
        result
    })
    .collect();
    Study {
        title: "Compare measured storage savings",
        intro: "Inspect real before-and-after target/ measurements from Bevy, Polars, Ruff, and uv.",
        method: "Measured across paired empty-target runs with full debug info (debug = 2) and incremental compilation enabled. Full metrics JSON and reproduction scripts are linked above.",
        scenes,
        sources: vec![
            source(
                "rust-target-guide",
                "TARGET-SIZE.md on GitHub",
                "Full guide, methodology, and machine-readable benchmark JSONs across Cargo, rustc, and Wild.",
                Some("https://github.com/sharifhsn/rust/blob/main/TARGET-SIZE.md"),
            ),
            source(
                "cargo-retention",
                "Cargo active-artifacts branch",
                "Experimental -Zactive-artifacts implementation and 29 regression tests.",
                Some("https://github.com/sharifhsn/cargo/tree/codex/active-artifacts"),
            ),
            source(
                "wild-compact",
                "Wild compact-artifacts branch",
                "Direct compact-library linking and content-addressed ELF object storage.",
                Some("https://github.com/sharifhsn/wild/tree/codex/compact-artifacts-2026-09-28"),
            ),
        ],
        audio: None,
    }
}
