defmodule Camping.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add(:code, :integer)
      add(:name, :string)
      add(:description, :string)
      add(:category, :string)
      add(:brand, :string)
      add(:obs, :string)
      add(:stock, :integer)
      add(:image, :string)
      add(:price, :float)

      timestamps()
    end

    create index(:products, [:code])
    create index(:products, [:category])
  end
end
