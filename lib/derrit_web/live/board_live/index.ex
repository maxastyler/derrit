defmodule DerritWeb.BoardLive.Index do
  use DerritWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, boards: Derrit.CMS.list_boards())}
  end
end
