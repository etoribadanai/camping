defmodule Camping.Repo.Migrations.AddNameCategoryToProducts do
  use Ecto.Migration

  def change do
    rename table(:products), :description, to: :name

    alter table(:products) do
      add(:description, :string)
      add(:category, :string)
    end
  end
end
