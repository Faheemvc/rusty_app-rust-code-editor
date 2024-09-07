use rustler::{Encoder, Env, Term};
use rhai::{Engine, Scope};

#[rustler::nif]
fn add(a: i64, b: i64) -> i64 {
    a + b
}

#[rustler::nif]
fn execute_rhai(script: String, params: Vec<String>) -> String {
    let mut engine = Engine::new();
    let mut scope = Scope::new();

    // Add parameters to scope
    for (i, param) in params.iter().enumerate() {
        scope.push(format!("param{}", i), param.clone());
    }

    match engine.eval_with_scope::<rhai::Dynamic>(&mut scope, &script) {
        Ok(result) => result.to_string(),
        Err(e) => format!("Error: {}", e),
    }
}

rustler::init!("Elixir.RustyApp.RhaiRustler", [execute_rhai, add]);