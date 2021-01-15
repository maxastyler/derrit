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
    case CMS.create_comment(
           Map.merge(comment_params, %{
             "post_id" => socket.assigns.post_id,
             "author_id" => socket.assigns.user.author.id
           })
         ) do
      {:ok, _comment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Comment created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
