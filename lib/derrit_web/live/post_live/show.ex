defmodule DerritWeb.PostLive.Show do
  use DerritWeb, :live_view

  alias Derrit.CMS
  alias Derrit.CMS.{Comment, Post}

  @impl true
  def mount(_param, session, socket) do
    user =
      case session["user_token"] do
        nil ->
          nil

        token ->
          Derrit.Accounts.get_user_by_session_token(token) |> Derrit.Repo.preload([:author])
      end

    {:ok, assign(socket, :user, user)}
  end

  @impl true
  def handle_params(%{"post_id" => post_id}, _, socket) do
    post = CMS.get_post!(post_id) |> Derrit.Repo.preload([comment: [:author]])
    {:noreply,
     case socket.assigns.live_action do
       :new ->
         socket |> assign(page_title: "New comment", post: post, comment: %Comment{})

       _ ->
         socket |> assign(page_title: post.title, post: post, comment: nil)
     end}
  end
end
