#[inline(never)]
fn add_one(x: i32) -> i32 { x + 1 }
fn main() { for x in [-2, 0, 7, 41] { println!("{} -> {}", x, add_one(x)); } }
