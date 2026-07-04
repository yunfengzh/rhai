default:
	cargo run --features sync,serde --example datarace

# git grep DataRace
# src/eval/target.rs:415 DataRace begin, Target::try_from(value: &'a mut Dynamic).
