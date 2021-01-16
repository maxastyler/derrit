defmodule DerritWeb.PostLive.Show do
  use DerritWeb, :live_view

  alias Derrit.CMS
  alias Derrit.CMS.{Comment, Post}

  @impl true
  def mount(_param, session, socket) do
    {:ok, assign_user_token(socket, session)}
  end

  @impl true
  def handle_params(%{"post_id" => post_id}, uri, socket) do
    post = CMS.get_post!(post_id) |> Derrit.Repo.preload(comment: [:author])

    {:noreply,
     socket
     |> assign(post: post, uri: URI.parse(uri).path)
     |> assign(
       case socket.assigns.live_action do
         :new -> [page_title: "New comment", comment: %Comment{}]
         _ -> [page_title: post.title, comment: nil]
       end
     )}
  end
end
