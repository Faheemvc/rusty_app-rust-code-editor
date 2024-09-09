defmodule RustyAppWeb.RustyFunctionsLive.Show do
  use RustyAppWeb, :live_view

  alias RustyApp.RustyFunction

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:rusty_functions, RustyFunction.get_rusty_functions!(id))}
  end

  defp page_title(:show), do: "Show Rusty functions"
  defp page_title(:edit), do: "Edit Rusty functions"
end
