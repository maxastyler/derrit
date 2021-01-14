defmodule Derrit.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :text, :string, null: false
      add :author_id, references(:authors, on_delete: :nothing)
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:author_id])
    create index(:comments, [:post_id])
  end
end
