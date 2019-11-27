defmodule Camping.Repo.Migrations.AddFieldsCampingsTable do
  use Ecto.Migration

  def change do
    alter table(:campings) do
      add :description, :text
    end
  end
end
