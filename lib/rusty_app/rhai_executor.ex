defmodule RustyApp.RhaiExecutor do
  use Rustler,
    otp_app: :rusty_app,
    crate: "rhai_rustler"

  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def execute_rhai(_script, _params), do: :erlang.nif_error(:nif_not_loaded)
  def dyn_execute_rhai(_script, _params), do: :erlang.nif_error(:nif_not_loaded)
end
