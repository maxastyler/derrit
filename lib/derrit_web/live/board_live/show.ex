defmodule DerritWeb.BoardLive.Show do
  use DerritWeb, :live_view

  alias Derrit.CMS
  alias Derrit.CMS.{Board, Post}

  @impl true
  def mount(_params, session, socket) do
    {:ok, assign_user_token(socket, session)}
  end

  @impl true
  def handle_params(%{"board_name" => board_name}, uri, socket) do
    board = CMS.get_board_by_name!(board_name) |> Derrit.Repo.preload(posts: [:author])

    {:noreply,
     case socket.assigns.live_action do
       :new ->
         socket |> assign(page_title: "New Post in #{board.name}", board: board, post: %Post{})

       _ ->
         socket |> assign(page_title: board.name, board: board, post: nil)
     end
     |> assign(uri: URI.parse(uri).path)}
  end
end
