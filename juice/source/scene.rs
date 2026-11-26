//! Browser-local Tideway edit state. Each successful move and undo advances the revision.
use std::cell::RefCell;

struct Scene {
    station: u32,
    revision: u32,
    history: Vec<u32>,
}

thread_local! {
    static SCENE: RefCell<Scene> = const { RefCell::new(Scene {
        station: 50, revision: 0, history: Vec::new()
    }) };
}

#[no_mangle]
pub extern "C" fn station_cm() -> u32 {
    SCENE.with_borrow(|s| s.station)
}

#[no_mangle]
pub extern "C" fn revision() -> u32 {
    SCENE.with_borrow(|s| s.revision)
}

#[no_mangle]
pub extern "C" fn undo_depth() -> u32 {
    SCENE.with_borrow(|s| s.history.len() as u32)
}

#[no_mangle]
pub extern "C" fn move_grate(expected: u32, station: u32) -> bool {
    SCENE.with_borrow_mut(|s| {
        if s.revision != expected || !matches!(station, 50 | 72 | 83) || s.station == station {
            return false;
        }
        s.history.push(s.station);
        s.station = station;
        s.revision += 1;
        true
    })
}

#[no_mangle]
pub extern "C" fn undo(expected: u32) -> bool {
    SCENE.with_borrow_mut(|s| {
        if s.revision != expected {
            return false;
        }
        let Some(previous) = s.history.pop() else { return false };
        s.station = previous;
        s.revision += 1;
        true
    })
}
