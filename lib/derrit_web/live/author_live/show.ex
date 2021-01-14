defmodule DerritWeb.AuthorLive.Show do
  use DerritWeb, :live_view

  alias Derrit.CMS
  alias Derrit.CMS.Author

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"author_id" => author_id}, _, socket) do
    author = CMS.get_author!(author_id)
    {:noreply, assign(socket, author: author)}
  end
end
