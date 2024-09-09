defmodule RustyAppWeb.RustyFunctionsLive.Index do
  use RustyAppWeb, :live_view

  alias RustyApp.RustyFunction
  alias RustyApp.RustyFunction.RustyFunctions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :rust_functions, RustyFunction.list_rust_functions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Rusty functions")
    |> assign(:rusty_functions, RustyFunction.get_rusty_functions!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Rusty functions")
    |> assign(:rusty_functions, %RustyFunctions{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rust functions")
    |> assign(:rusty_functions, nil)
  end

  @impl true
  def handle_info({RustyAppWeb.RustyFunctionsLive.FormComponent, {:saved, rusty_functions}}, socket) do
    {:noreply, stream_insert(socket, :rust_functions, rusty_functions)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    rusty_functions = RustyFunction.get_rusty_functions!(id)
    {:ok, _} = RustyFunction.delete_rusty_functions(rusty_functions)

    {:noreply, stream_delete(socket, :rust_functions, rusty_functions)}
  end
end
