defmodule Derrit.CMS.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :title, :string
    belongs_to :board, Derrit.CMS.Board
    belongs_to :author, Derrit.CMS.Author
    has_many :comment, Derrit.CMS.Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :board_id, :author_id])
    |> validate_required([:title, :board_id, :author_id])
    |> assoc_constraint(:board)
    |> assoc_constraint(:author)
  end
end
