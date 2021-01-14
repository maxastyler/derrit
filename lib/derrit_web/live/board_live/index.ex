defmodule DerritWeb.BoardLive.Index do
  use DerritWeb, :live_view

  alias Derrit.CMS
  alias Derrit.CMS.Board

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, boards: Derrit.CMS.list_boards())}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply,
     if socket.assigns.live_action == :new do
       socket
       |> assign(:page_title, "New Board")
       |> assign(:board, %Board{})
     else
       socket
       |> assign(:page_title, "Listing Boards")
       |> assign(:board, nil)
     end}
  end
end
