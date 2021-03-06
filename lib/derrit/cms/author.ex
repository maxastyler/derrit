defmodule Derrit.CMS.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :bio, :string
    field :name, :string
    belongs_to :user, Derrit.Accounts.User
    has_many :posts, Derrit.CMS.Post

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :bio, :user_id])
    |> validate_required([:name, :user_id])
    |> assoc_constraint(:user)
  end
end
