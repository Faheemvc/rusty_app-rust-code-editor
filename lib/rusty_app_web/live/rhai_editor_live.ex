defmodule RustyAppWeb.RhaiEditorLive do
  use RustyAppWeb, :live_view
  alias RustyApp.RhaiFunctions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, functions: list_functions(), current_function: nil, result: nil)}
  end

  @impl true
  def handle_event("select_function", %{"name" => name}, socket) do
    {:ok, body} = RhaiFunctions.get_function(name)
    {:noreply, assign(socket, current_function: %{name: name, body: body})}
  end

  @impl true
  def handle_event("save_function", %{"name" => name, "body" => body}, socket) do
    RhaiFunctions.save_function(name, body)
    {:noreply, assign(socket, functions: list_functions(), current_function: %{name: name, body: body})}
  end

  @impl true
  def handle_event("execute_function", %{"name" => name, "params" => params}, socket) do
    result = RhaiFunctions.execute_function(name, String.split(params, ","))
    {:noreply, assign(socket, result: result)}
  end

  @impl true
  def handle_event("delete_function", %{"name" => name}, socket) do
    RhaiFunctions.delete_function(name)
    {:noreply, assign(socket, functions: list_functions(), current_function: nil)}
  end

  defp list_functions do
    case RhaiFunctions.list_functions() do
      {:ok, functions} -> functions
      _ -> []
    end
  end
end
