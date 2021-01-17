defmodule DerritWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `DerritWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, DerritWeb.AuthorLive.FormComponent,
        id: @author.id || :new,
        action: @live_action,
        author: @author,
        return_to: Routes.author_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, DerritWeb.ModalComponent, modal_opts)
  end

  @doc """
  If the session has a user_token in it, assign it to the socket
  """
  def assign_user_token(socket, %{"user_token" => user_token}) do
    Phoenix.LiveView.assign_new(socket, :user_token, fn -> user_token end)
  end

  def assign_user_token(socket, _),
    do: Phoenix.LiveView.assign_new(socket, :user_token, fn -> nil end)

  @doc """
  If there's a valid session token in the socket, get the associated author. 
  Otherwise, return an {:error, ...} tuple
  """
  def author_from_socket(socket) do
    with token when token != nil <- socket.assigns.user_token,
         user when user != nil <- Derrit.Accounts.get_user_by_session_token(token),
         user <- Derrit.Repo.preload(user, :author) do
      {:ok, user.author}
    else
      _ -> {:error, "no valid user in socket"}
    end
  end

  @doc """
  Redirect the user to the login page, with an optional flash message.
  """
  def redirect_to_login(socket, redirect_path, flash_message \\ "You need to log in.") do
    socket
    |> Phoenix.LiveView.put_flash(:error, flash_message)
    |> Phoenix.LiveView.redirect(
      to: DerritWeb.Router.Helpers.user_session_path(socket, :new, return_to: redirect_path)
    )
  end
end
