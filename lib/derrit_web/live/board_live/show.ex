defmodule DerritWeb.BoardLive.Show do
  use DerritWeb, :live_view

  alias Derrit.CMS
  alias Derrit.CMS.{Board, Post}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"board_id" => board_id}, _, socket) do
    board = CMS.get_board!(board_id) |> Derrit.Repo.preload([:posts])

    {:noreply,
     case socket.assigns.live_action do
       :new ->
         socket |> assign(page_title: "New Post in #{board.name}", board: board, post: %Post{})

       _ ->
         socket |> assign(page_title: board.name, board: board, post: nil)
     end}
  end
end
