defmodule Camping.Repo.Migrations.TagsOptions do
  use Ecto.Migration

  def change do
    create table(:tag_options) do
      add(:tag_id, references(:tags, on_delete: :nothing), null: false)
      add :values, :string

      timestamps()
    end
  end
end
