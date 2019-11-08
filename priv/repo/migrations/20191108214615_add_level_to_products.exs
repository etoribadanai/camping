defmodule Camping.Repo.Migrations.AddLevelToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :level, :string
    end
  end
end
