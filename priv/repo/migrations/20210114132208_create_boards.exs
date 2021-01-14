defmodule Derrit.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :name, :string, null: false
      add :description, :string

      timestamps()
    end

    create unique_index(:boards, [:name])
  end
end
