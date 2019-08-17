defmodule Camping.Repo.Migrations.Tags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string

      timestamps()
    end
  end
end
