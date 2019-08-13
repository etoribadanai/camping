defmodule Camping.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add(:obs, :string)
      add(:customer_id, references(:customers, on_delete: :nothing))

      timestamps()
    end

    create(index(:orders, [:customer_id]))
  end
end
