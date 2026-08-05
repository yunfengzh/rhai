# vim: foldmarker=<([{,}])> foldmethod=marker
default:
	cargo run --features sync,serde --example crossref

debug:
	rust-gdb -x my.gdbscript target/debug/examples/crossref

# git grep DataRace
# src/eval/target.rs:415 DataRace begin, Target::try_from(value: &'a mut Dynamic).

# TODO: setup cycle tree to detect crossref.
# Or discard the feature at all.
# TODO: discard var shadow?
# crossref <([{
# To pass tests, example/crossref.rs, currently solution has bug.
# 1. duplicating var definitions in global scope.
# 2. ErrorFunctionNotFound("+ ((), i64)", 2:15), to `let a = b + 1;`.
# src/eval/stmt.rs: 386, Engine::eval_stmt().
# self.allow_shadowing()?, Engine::options which is `pub(crate)`, so change code to disable it.
# engine.set_allow_shadowing(false);

# src/eval/expr.rs|145 col 42-63| Err(ERR::ErrorVariableNotFound(
# src/eval/expr.rs|185 col 42-63| Err(ERR::ErrorVariableNotFound(
# src/eval/expr.rs|216 col 41-62| return Err(ERR::ErrorVariableNotFound(
# Engine::eval_stmt
# src/eval/stmt.rs|968 col 33-54| || Err(ERR::ErrorVariableNotFound(name.to_string(), *pos).into()),
#            Stmt::Export(x, ..) => {
# src/eval/stmt.rs|1011 col 43-64| Box::new(ERR::ErrorVariableNotFound(var.name.to_string(), var.pos))
#            Stmt::Share(x) => { <<<<
# 385, branch variable definition.
# TODO: scan_var_def() based on above 385 line.
# src/api/eval.rs: eval_ast_with_scope_raw >> eval_global_statements
# default Dynamic is Dynamic::UNIT.
# feature no_module to disable import statement.
# }])>
