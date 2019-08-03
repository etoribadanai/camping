defmodule Camping.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add(:obs, :string)
      add(:user_id, references(:customers, on_delete: :nothing))

      timestamps()
    end

    create(index(:orders, [:user_id]))
  end
end
