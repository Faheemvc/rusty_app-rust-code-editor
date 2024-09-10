defmodule RustyAppWeb.RhaiEditorLive do
  use RustyAppWeb, :live_view
  alias RustyApp.RhaiExecutor

  def mount(_params, _session, socket) do
    socket =
    socket
    |> assign(code: "", params: "", result: nil)
    |> stream(:rust_functions, RustyApp.RustyFunction.list_rust_functions())

   {:ok, socket}
  end

  def handle_event("get_function", %{"id" => id_str}, socket) do
    function = RustyApp.RustyFunction.get_rusty_functions!(id_str)

    socket =
      socket
      |> assign(code: function.body)
      |> assign(params: function.params || "")
      |> stream(:rust_functions, RustyApp.RustyFunction.list_rust_functions())

    {:noreply, socket}
  end

  def handle_event("update_code", %{"code" => code}, socket) do
    {:noreply, assign(socket, code: code)}
  end

  def handle_event("update_params", %{"params" => params}, socket) do
    {:noreply, assign(socket, params: params)}
  end

  def handle_event("execute_rhai", _, socket) do

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

    socket = stream(socket, :rust_functions, RustyApp.RustyFunction.list_rust_functions())
    result = RhaiExecutor.dyn_execute_rhai(socket.assigns.code, params)
    
    {:noreply, assign(socket, result: result)}
  end

  def handle_event("clear_editor", _, socket) do
    socket =
      socket
      |> assign(code: "")
      |> assign(params: "")
      |> stream(:rust_functions, RustyApp.RustyFunction.list_rust_functions())

    {:noreply, socket}
  end
end
