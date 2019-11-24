defmodule Camping.Repo.Migrations.CreateCampingsTable do
  use Ecto.Migration

  def change do
    create table(:campings) do
      add :name, :string
      add :state, :string
      add :city, :string
      add :distance_from_capital, :float

      timestamps()
    end

    create index(:campings, [:state])
    create index(:campings, [:city])
  end
end
