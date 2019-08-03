defmodule Camping.Repo.Migrations.CreateSocialLogin do
  use Ecto.Migration

  def change do
    create table(:social_logins) do
      add :email, :string
      add :customer_id, references(:customers, on_delete: :delete_all), null: false
      add :uid, :string
      add :image, :string
      add :provider, :string
      add :token, :string

      timestamps()
    end

    create unique_index(:social_logins, [:customer_id])
    create(unique_index(:social_logins, [:email]))
  end
end
