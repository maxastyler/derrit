defmodule DerritWeb.BoardLive.NewPostComponent do
  use DerritWeb, :live_component
  alias Derrit.CMS

  @impl true
  def update(%{post: post} = assigns, socket) do
    changeset = CMS.change_post(post)
    {:ok, socket |> assign(assigns) |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"post" => post_params}, socket) do
    changeset = socket.assigns.post |> CMS.change_post(post_params) |> Map.put(:action, :validate)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"post" => post_params}, socket) do
    save_post(socket, socket.assigns.action, post_params)
  end

  defp save_post(socket, :new, post_params) do
    with {:ok, author} <- author_from_socket(socket),
         {:ok, _post} <-
           CMS.create_post(
             Map.merge(post_params, %{
               "board_id" => socket.assigns.board_id,
               "author_id" => author.id
             })
           ) do
      {:noreply,
       socket
       |> put_flash(:info, "Post created successfully")
       |> push_redirect(to: socket.assigns.return_to)}
    else
      {:error, "no valid user in socket"} ->
        {:noreply,
         redirect_to_login(socket, socket.assigns.uri, "You need to log in to post.")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
