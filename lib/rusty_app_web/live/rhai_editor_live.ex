defmodule RustyAppWeb.RhaiEditorLive do
  use RustyAppWeb, :live_view
  alias RustyApp.RhaiExecutor

  def mount(_params, _session, socket) do
    {:ok, assign(socket, code: "", params: "", result: nil)}
  end

  def handle_event("update_code", %{"code" => code}, socket) do
    {:noreply, assign(socket, code: code)}
  end

  def handle_event("update_params", %{"params" => params}, socket) do
    {:noreply, assign(socket, params: params)}
  end

  def handle_event("execute_rhai", _, socket) do
    IO.inspect(socket.assigns, label: "assigns at execute")

    params =
      socket.assigns.params
      |> String.split(",", trim: true)
      |> Enum.map(&String.trim/1)
      |> Enum.map(fn param ->
        case Integer.parse(param) do
          {int, _} -> int
          _ -> param
        end
      end)

    IO.inspect(params, label: "params at execute")
    IO.inspect(socket.assigns.code, label: "code at execute")

    result = RhaiExecutor.dyn_execute_rhai(socket.assigns.code, params)
    {:noreply, assign(socket, result: result)}
  end
end
