defmodule RustyAppWeb.RustyFunctionsLive.FormComponent do
  use RustyAppWeb, :live_component

  alias RustyApp.RustyFunction

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage rusty_functions records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="rusty_functions-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:body]} type="text" label="Body" />
        <%!-- <.input field={@form[:params]} type="text" label="Params" /> --%>
        <:actions>
          <.button phx-disable-with="Saving...">Save Rusty functions</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{rusty_functions: rusty_functions} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(RustyFunction.change_rusty_functions(rusty_functions))
     end)}
  end

  @impl true
  def handle_event("validate", %{"rusty_functions" => rusty_functions_params}, socket) do
    changeset = RustyFunction.change_rusty_functions(socket.assigns.rusty_functions, rusty_functions_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"rusty_functions" => rusty_functions_params}, socket) do
    save_rusty_functions(socket, socket.assigns.action, rusty_functions_params)
  end

  defp save_rusty_functions(socket, :edit, rusty_functions_params) do
    case RustyFunction.update_rusty_functions(socket.assigns.rusty_functions, rusty_functions_params) do
      {:ok, rusty_functions} ->
        notify_parent({:saved, rusty_functions})

        {:noreply,
         socket
         |> put_flash(:info, "Rusty functions updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_rusty_functions(socket, :new, rusty_functions_params) do
    case RustyFunction.create_rusty_functions(rusty_functions_params) do
      {:ok, rusty_functions} ->
        notify_parent({:saved, rusty_functions})

        {:noreply,
         socket
         |> put_flash(:info, "Rusty functions created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
