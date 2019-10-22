defmodule Camping.Repo.Migrations.ChangeTypeOfTokenSocial do
  use Ecto.Migration

  def change do
    alter table(:social_logins) do
      modify :token, :text
    end
  end
end
