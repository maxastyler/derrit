defmodule DerritWeb.PostLive.Show do
  use DerritWeb, :live_view

  alias Derrit.CMS
  alias Derrit.CMS.Post

  @impl true
  def mount(_param, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"post_id" => post_id}, _, socket) do
    post = CMS.get_post!(post_id)
    {:noreply, assign(socket, post: post)}
  end
end
