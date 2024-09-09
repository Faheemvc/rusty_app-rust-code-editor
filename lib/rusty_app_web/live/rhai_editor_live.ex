defmodule RustyAppWeb.RhaiEditorLive do
  use RustyAppWeb, :live_view
  alias RustyApp.RhaiFunctions


  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(functions: list_functions(), current_function: nil, result: nil, params: "")
     |> push_event("init_editor", %{})}
  end

  @impl true
  def handle_event("load_function", %{"name" => name}, socket) do
    {:ok, body} = RhaiFunctions.get_function(name)
    {:noreply,
     socket
     |> assign(current_function: %{name: name, body: body})
     |> push_event("update_editor", %{code: body})}
  end

  @impl true
  def handle_event("save_function", %{"name" => name, "body" => body}, socket) do
    RhaiFunctions.save_function(name, body)
    {:noreply,
     socket
     |> assign(functions: list_functions(), current_function: %{name: name, body: body})
     |> put_flash(:info, "Function saved successfully!")}
  end

  def handle_event("create_function", %{"value" => ""}, socket) do
    # Handle the case where the function input is empty
    {:noreply, assign(socket, :result, "Function input cannot be empty")}
  end

  @impl true
  def handle_event("create_function", %{"name" => name}, socket) do
    {:noreply,
     socket
     |> assign(current_function: %{name: name, body: ""})
     |> push_event("update_editor", %{code: ""})}
  end

  @impl true
  def handle_event("execute_function", %{"params" => params}, socket) do
    %{name: name, body: body} = socket.assigns.current_function
    result = RhaiFunctions.execute_function(name, [params]) #String.split(params, ",", trim: true))
    {:noreply, assign(socket, result: result)}
  end

  @impl true
  def handle_event("update_params", %{"params" => params}, socket) do
    {:noreply, assign(socket, params: params)}
  end

  defp list_functions do
    case RhaiFunctions.list_functions() do
      {:ok, functions} -> functions
      _ -> []
    end
  end
end
