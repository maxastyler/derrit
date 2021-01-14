defmodule Derrit.CMS.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :bio, :string
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :bio])
    |> validate_required([:name, :bio])
  end
end
