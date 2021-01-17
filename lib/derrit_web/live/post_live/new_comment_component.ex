defmodule DerritWeb.PostLive.NewCommentComponent do
  use DerritWeb, :live_component
  alias Derrit.CMS

  @impl true
  def update(%{comment: comment} = assigns, socket) do
    changeset = CMS.change_comment(comment)
    {:ok, socket |> assign(assigns) |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"comment" => comment_params}, socket) do
    changeset =
      socket.assigns.comment |> CMS.change_comment(comment_params) |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"comment" => comment_params}, socket) do
    save_comment(socket, socket.assigns.action, comment_params)
  end

  defp save_comment(socket, :new, comment_params) do
    with {:ok, author} <- author_from_socket(socket),
         {:ok, comment} <-
           CMS.create_comment(
             Map.merge(comment_params, %{
               "post_id" => socket.assigns.post_id,
               "author_id" => author.id
             })
           ) do
      DerritWeb.Endpoint.broadcast("post:#{socket.assigns.post_id}", "comment_added", comment)
      {:noreply,
       socket
       |> put_flash(:info, "Comment created successfully")
       |> push_redirect(to: socket.assigns.return_to)}
    else
      {:error, "no valid user in socket"} ->
        {:noreply,
         redirect_to_login(
           socket,
           socket.assigns.uri,
           "You need to be signed in to post a comment."
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
