defmodule Camping.Repo.Migrations.AddKindTrail do
  use Ecto.Migration

  def change do
    alter table(:trails) do
      add :kind, :integer
    end
  end
end
