defmodule Camping.Repo.Migrations.AddNameCategoryToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add(:name, :string)
      add(:category, :string)
    end
  end
end
