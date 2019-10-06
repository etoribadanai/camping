defmodule Camping.Repo.Migrations.TrailDescription do
  use Ecto.Migration

  def change do
    alter table(:trails) do
      add :description, :text
    end
  end
end
