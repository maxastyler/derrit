defmodule DerritWeb.PostLive.Show do
  use DerritWeb, :live_view

  alias Derrit.CMS
  alias Derrit.CMS.{Comment, Post}

  @impl true
  def mount(_param, session, socket) do
    {:ok, assign_user_token(socket, session), temporary_assigns: [comments: []]}
  end

  @impl true
  def handle_params(%{"post_id" => post_id}, uri, socket) do
    post = CMS.get_post!(post_id)
    comments = CMS.get_comments_for_post(post)

    if connected?(socket) do
      if Map.get(socket.assigns, :post) != nil do
        DerritWeb.Endpoint.unsubscribe("post:#{socket.assigns.post.id}")
      end

      DerritWeb.Endpoint.subscribe("post:#{post.id}")
    end

    {:noreply,
     socket
     |> assign(post: post, comments: comments, uri: URI.parse(uri).path)
     |> assign(
       case socket.assigns.live_action do
         :new -> [page_title: "New comment", comment: %Comment{}]
         _ -> [page_title: post.title, comment: nil]
       end
     )}
  end

  @impl true
  def handle_info(%{event: "comment_added", payload: comment}, socket) do
    {:noreply, update(socket, :comments, fn c -> [comment | c] end)}
  end
end
