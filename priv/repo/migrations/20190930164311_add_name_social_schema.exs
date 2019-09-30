defmodule Camping.Repo.Migrations.AddNameSocialSchema do
  use Ecto.Migration

  def change do
    alter table(:social_logins) do
      add :name, :string
    end
  end
end
