defmodule Camping.Repo.Migrations.TrailTagOptions do
  use Ecto.Migration

  def change do
    create table(:trail_tag_options) do
      add(:trail_id, references(:trails, on_delete: :nothing), null: false)
      add(:tag_id, references(:tags, on_delete: :nothing), null: false)
      add(:tag_option_id, references(:tag_options, on_delete: :nothing), null: false)

      timestamps()
    end
  end
end
