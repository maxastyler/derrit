defmodule Derrit.CMS.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :text, :string
    belongs_to :author, Derrit.CMS.Author
    belongs_to :post, Derrit.CMS.Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :author_id, :post_id])
    |> validate_required([:text, :author_id, :post_id])
    |> assoc_constraint(:post)
    |> assoc_constraint(:author)
  end
end
