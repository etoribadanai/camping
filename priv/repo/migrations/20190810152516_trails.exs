defmodule Camping.Repo.Migrations.Trails do
  use Ecto.Migration

  def change do
    create table(:trails) do
      add :name, :string
      add :state, :string
      add :city, :string
      add :level, :string
      add :distance, :float
      add :duration, :float
      add :distance_from_capital, :float
      add :start, :string
      add :finish, :string
      add :nearby, :string

      timestamps()
    end

    create index(:trails, [:city])
  end
end
