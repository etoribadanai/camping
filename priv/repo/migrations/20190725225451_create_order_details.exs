defmodule Camping.Repo.Migrations.CreateOrderDetails do
  use Ecto.Migration

  def change do
    create table(:orders_details) do
      add(:order_id, references(:orders, on_delete: :nothing), null: false)
      add(:product_id, references(:products, on_delete: :nothing), null: false)
      add(:purchased, :boolean)

      timestamps()
    end

    create(index(:orders_details, [:order_id]))
    create(index(:orders_details, [:product_id]))
  end
end
