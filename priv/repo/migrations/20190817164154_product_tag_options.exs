defmodule Camping.Repo.Migrations.ProductTagOptions do
  use Ecto.Migration

  def change do
    create table(:product_tag_options) do
      add(:product_id, references(:products, on_delete: :nothing), null: false)
      add(:tag_id, references(:tags, on_delete: :nothing), null: false)
      add(:tag_option_id, references(:tag_options, on_delete: :nothing), null: false)

      timestamps()
    end
  end
end
