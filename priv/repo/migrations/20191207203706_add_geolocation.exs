defmodule Camping.Repo.Migrations.AddGeolocation do
  use Ecto.Migration

  def change do
    alter table(:trails) do
      add :latitude, :float
      add :longitude, :float
    end

    alter table(:campings) do
      add :latitude, :float
      add :longitude, :float
    end
  end
end
