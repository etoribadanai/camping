defmodule Camping.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:customers, [:email])
  end
end
