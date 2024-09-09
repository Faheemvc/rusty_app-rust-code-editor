use rhai::{Engine, Scope, Dynamic};
use rustler::{Term, NifResult};
use std::sync::Mutex;
use lazy_static::lazy_static;

lazy_static! {
    static ref STDOUT: Mutex<Vec<u8>> = Mutex::new(Vec::new());
}

#[rustler::nif]
fn add(a: i64, b: i64) -> i64 {
    a + b
}

#[rustler::nif]
fn execute_rhai(script: String, params: Vec<String>) -> String {
    let engine = Engine::new();
    let mut scope = Scope::new();

    for (i, param) in params.iter().enumerate() {
        scope.push(format!("param{}", i), param.clone());
    }

    match engine.eval_with_scope::<Dynamic>(&mut scope, &script) {
        Ok(result) => result.to_string(),
        Err(e) => format!("Error: {}", e),
    }
}

// Helper function to convert a Term to a Rhai Dynamic
fn term_to_dynamic(term: &Term) -> NifResult<Dynamic> {
    if let Ok(int_val) = term.decode::<i64>() {
        Ok(Dynamic::from(int_val))
    } else if let Ok(float_val) = term.decode::<f64>() {
        Ok(Dynamic::from(float_val))
    } else if let Ok(string_val) = term.decode::<String>() {
        Ok(Dynamic::from(string_val))
    } else {
        // Add more conversions if needed
        Err(rustler::Error::BadArg)
    }
}

#[rustler::nif]
fn dyn_execute_rhai(script: String, params: Vec<Term>) -> NifResult<String> {
    let mut engine = Engine::new();
    
    STDOUT.lock().unwrap().clear();
    
    engine.on_print(|x| {
        STDOUT.lock().unwrap().extend_from_slice(x.as_bytes());
        STDOUT.lock().unwrap().push(b'\n');
    });
    
    let mut scope = Scope::new();

    for (i, param) in params.iter().enumerate() {
        let dynamic_value: Dynamic = term_to_dynamic(param)?;
        scope.push(format!("param{}", i), dynamic_value);
    }

    match engine.eval_with_scope::<Dynamic>(&mut scope, &script) {
        Ok(result) => {
            let output = STDOUT.lock().unwrap().clone();
            let output_str = String::from_utf8_lossy(&output);
            
            Ok(format!("Output: {}\nResult: {}", output_str.trim(), result.to_string()))
        },
        Err(e) => Ok(format!("Error: {}", e)),
    }
}

rustler::init!("Elixir.RustyApp.RhaiExecutor");