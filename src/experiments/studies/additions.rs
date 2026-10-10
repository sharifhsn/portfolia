use super::*;

pub(super) fn build(slug: &str) -> Option<Study> {
    Some(match slug {
        "factshort" => claims(),
        "guphub" => rooms(),
        "cugen-layout" => packed_values(),
        "oboromi" => machine(),
        _ => return None,
    })
}

fn claims() -> Study {
    let evidence = "The imaginary Sample Desk runs on macOS and stores results locally. Linux support is the next development task.";
    let scenes = [
        ("Supported", "The Sample Desk stores results locally.", "Supported", "The source says the application stores results locally, so it supports the claim."),
        ("Contradicted", "Linux support is complete.", "Contradicted", "The source lists Linux support as the next development task, which contradicts the claim that it is complete."),
        ("No evidence", "The Sample Desk has ten thousand users.", "Insufficient evidence", "The source gives no user count. The assessment records the missing evidence."),
    ].into_iter().map(|(label, claim, decision, reason)| {
        let mut result = scene(label, "A claim stays beside its evidence", reason);
        result.input = claim.into();
        result.output = format!("Assessment: {decision}\nReason: {reason}");
        result.citations.push("claim-1".into());
        result.svg = svg("A claim connects to a source and an assessment", "<rect x=\"25\" y=\"85\" width=\"120\" height=\"85\" fill=\"none\" stroke=\"currentColor\"/><rect x=\"180\" y=\"85\" width=\"120\" height=\"85\" fill=\"none\" stroke=\"currentColor\"/><rect x=\"335\" y=\"85\" width=\"120\" height=\"85\" fill=\"none\" stroke=\"currentColor\"/><path d=\"M145 127h35m120 0h35\" stroke=\"currentColor\"/><text x=\"65\" y=\"133\">Claim</text><text x=\"208\" y=\"133\">Source</text><text x=\"355\" y=\"133\">Decision</text>");
        result
    }).collect();
    Study {
        title: "Three claims, one source",
        intro: "Put three claims against the same synthetic note. Follow the evidence to see why each gets a different assessment.",
        method: "The assessments are prewritten for this synthetic source. Rust exports the report views. FactShort's Python pipeline supplies the claim-research application.",
        scenes,
        sources: vec![source(
            "claim-1",
            "Original synthetic source note",
            evidence,
            None,
        )],
        audio: None,
    }
}

#[derive(Clone, Copy)]
enum Role {
    Host,
    Speaker,
    Listener,
}

fn publish_audio(role: Role, room_open: bool, invitation_accepted: bool) -> bool {
    room_open
        && (matches!(role, Role::Host) || matches!(role, Role::Speaker) && invitation_accepted)
}

fn rooms() -> Study {
    let scenes = [
        ("Host", Role::Host, true, true),
        ("Invited speaker", Role::Speaker, true, true),
        ("Listener", Role::Listener, true, false),
        ("Room closed", Role::Host, false, true),
    ].into_iter().map(|(label, role, open, accepted)| {
        let permitted = publish_audio(role, open, accepted);
        let mut result = scene(label, "One room, explicit audio roles", "An open room permits its host and accepted speakers to publish audio. Listeners receive audio. Close the room and every role loses publication access.");
        result.metrics = vec![metric("Room", if open { "Open" } else { "Closed" }), metric("Role", label), metric("Audio publication", if permitted { "Permitted" } else { "Denied" })];
        result.svg = svg("A control-plane decision precedes an audio connection", &format!(r#"<circle cx="90" cy="140" r="42" fill="none" stroke="currentColor"/><text x="58" y="145">Person</text><path d="M135 140h55m130 0h35" stroke="currentColor"/><rect x="190" y="90" width="130" height="100" fill="none" stroke="currentColor"/><text x="215" y="125">Role check</text><text x="216" y="157">{}</text><circle cx="399" cy="140" r="42" fill="none" stroke="currentColor"/><text x="376" y="145">Audio</text>"#, if permitted { "Allow" } else { "Deny" }));
        result.output = format!("can_publish_audio = {permitted}\nroom_open = {open}\ninvitation_accepted = {accepted}");
        result
    }).collect();
    Study {
        title: "The role decides who gets the microphone",
        intro: "Choose a role, then compare its publication permission with a closed room.",
        method: "Rust evaluates this policy for an imaginary room. The next integration matches these decisions to the Guphub control plane's LiveKit grants.",
        scenes,
        sources: vec![],
        audio: None,
    }
}

fn pack(values: [u8; 4]) -> Option<u8> {
    values
        .into_iter()
        .enumerate()
        .try_fold(0_u8, |byte, (index, value)| {
            (value <= 3).then_some(byte | (value << (index * 2)))
        })
}

fn unpack(byte: u8) -> [u8; 4] {
    [byte & 3, (byte >> 2) & 3, (byte >> 4) & 3, (byte >> 6) & 3]
}

fn packed_values() -> Study {
    let scenes = [[0, 1, 2, 3], [2, 2, 1, 0], [3, 3, 3, 3]].into_iter().map(|values| {
        let byte = pack(values).expect("The fixture contains only two-bit values");
        let mut result = scene(format!("{values:?}"), "Four two-bit values fit in one byte", "The first value occupies the two lowest bits. Decode the same positions to recover all four original values.");
        result.input = format!("values: {values:?}\nslot order: least significant first");
        result.output = format!("packed: 0x{byte:02x}\nbits: {byte:08b}\ndecoded: {:?}", unpack(byte));
        result.metrics = vec![metric("Input values", 4), metric("Packed bytes", 1), metric("Round trip", "Equal")];
        result.svg = svg("Eight bits grouped into four pairs", &(0..8).map(|bit| {
            let value = (byte >> (7 - bit)) & 1;
            format!(r#"<rect x="{}" y="105" width="43" height="58" fill="none" stroke="currentColor"/><text x="{}" y="141" font-size="23">{value}</text>"#, 25 + bit * 54, 39 + bit * 54)
        }).collect::<String>());
        result
    }).collect();
    Study {
        title: "A data-layout study",
        intro: "Choose a synthetic vector, then inspect its encoded byte and recovered values.",
        method: "Rust implements this independent two-bit example. The view does not implement the CuGen file format, run a GPU kernel, or establish an upstream contribution.",
        scenes,
        sources: vec![],
        audio: None,
    }
}

#[derive(Clone, Copy)]
enum Instruction {
    Load(u8),
    Add(u8),
    Halt,
}

fn execute(program: &[Instruction], limit: usize) -> Result<Vec<u8>, &'static str> {
    let mut value = 0_u8;
    let mut trace = vec![value];
    for (step, instruction) in program.iter().enumerate() {
        if step >= limit {
            return Err("Step limit reached");
        }
        match instruction {
            Instruction::Load(input) => value = *input,
            Instruction::Add(input) => {
                value = value.checked_add(*input).ok_or("Register overflow")?
            }
            Instruction::Halt => return Ok(trace),
        }
        trace.push(value);
    }
    Err("Program has no halt instruction")
}

fn machine() -> Study {
    let scenes = [
        ("A complete program", vec![Instruction::Load(7), Instruction::Add(5), Instruction::Halt], "LOAD 7\nADD 5\nHALT", 8),
        ("Overflow", vec![Instruction::Load(250), Instruction::Add(10), Instruction::Halt], "LOAD 250\nADD 10\nHALT", 8),
        ("Step limit", vec![Instruction::Load(7), Instruction::Add(5), Instruction::Halt], "LOAD 7\nADD 5\nHALT", 1),
    ].into_iter().map(|(label, program, input, limit)| {
        let mut result = scene(label, "One register and explicit execution limits", "The machine has one eight-bit register. Checked addition stops an overflow, and the step limit bounds execution. A successful program reaches HALT within that limit.");
        result.input = format!("{input}\n\nstep limit: {limit}");
        result.output = match execute(&program, limit) {
            Ok(trace) => format!("register trace: {trace:?}\nresult: {}\nstate: Halted", trace.last().expect("The trace includes the initial register")),
            Err(error) => format!("state: Rejected\nreason: {error}"),
        };
        result.svg = svg("A toy register before instruction execution", "<rect x=\"55\" y=\"85\" width=\"155\" height=\"100\" fill=\"none\" stroke=\"currentColor\"/><text x=\"78\" y=\"123\">Instruction</text><text x=\"88\" y=\"153\">decoder</text><path d=\"M210 135h65\" stroke=\"currentColor\"/><rect x=\"275\" y=\"85\" width=\"150\" height=\"100\" fill=\"none\" stroke=\"currentColor\"/><text x=\"306\" y=\"124\">Register</text><text x=\"304\" y=\"156\">8 bits</text>");
        result
    }).collect();
    Study {
        title: "Make execution limits visible",
        intro: "Run the same instruction set through successful execution, arithmetic overflow, and a step-limit failure. Each result shows where execution stops.",
        method: "Rust executes this original eight-bit instruction set and records the register trace. The next example uses an IPC packet from the local Oboromi parser work. 0xNikilite authors Oboromi.",
        scenes,
        sources: vec![source(
            "oboromi",
            "Upstream emulator foundation",
            "Reference: Oboromi by 0xNikilite. The browser example executes its own eight-bit instruction set.",
            Some("https://github.com/0xNikilite/oboromi"),
        )],
        audio: None,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn every_possible_packed_byte_round_trips() {
        for byte in 0..=u8::MAX {
            assert_eq!(pack(unpack(byte)), Some(byte));
        }
        assert_eq!(pack([0, 1, 2, 4]), None);
    }

    #[test]
    fn audio_grants_require_role_room_and_invitation() {
        assert!(publish_audio(Role::Host, true, false));
        assert!(publish_audio(Role::Speaker, true, true));
        assert!(!publish_audio(Role::Speaker, true, false));
        assert!(!publish_audio(Role::Listener, true, true));
        assert!(!publish_audio(Role::Host, false, true));
    }

    #[test]
    fn toy_machine_requires_a_bounded_complete_run() {
        assert_eq!(
            execute(
                &[Instruction::Load(7), Instruction::Add(5), Instruction::Halt],
                3
            ),
            Ok(vec![0, 7, 12])
        );
        assert_eq!(
            execute(
                &[
                    Instruction::Load(250),
                    Instruction::Add(10),
                    Instruction::Halt
                ],
                3
            ),
            Err("Register overflow")
        );
        assert_eq!(
            execute(&[Instruction::Load(7)], 3),
            Err("Program has no halt instruction")
        );
        assert_eq!(execute(&[Instruction::Halt], 0), Err("Step limit reached"));
    }
}
