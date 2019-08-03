defmodule Camping.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :customer_id, references(:customers, on_delete: :delete_all), null: false
      add :token, :text
      add :password_hash, :string

      timestamps()
    end

    create(unique_index(:users, [:customer_id]))
    create(unique_index(:users, [:email]))
  end
end
