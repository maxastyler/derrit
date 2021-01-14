defmodule Derrit.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :body, :string
      add :board_id, references(:boards, on_delete: :delete_all)
      add :author_id, references(:authors, on_delete: :delete_all)

      timestamps()
    end

    create index(:posts, [:board_id])
    create index(:posts, [:author_id])
  end
end
