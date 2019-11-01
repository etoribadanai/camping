defmodule Camping.Repo.Migrations.TrailsOptions do
  use Ecto.Migration

  def change do
     create table(:trail_options) do
      add(:trail_id, references(:trails, on_delete: :nothing), null: false)
      add(:option_id, references(:options, on_delete: :delete_all))

      timestamps()
    end
  end
end
