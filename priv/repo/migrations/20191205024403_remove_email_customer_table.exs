defmodule Camping.Repo.Migrations.RemoveEmailCustomerTable do
  use Ecto.Migration

  def change do
    alter table(:customers) do
      remove :email
    end
  end
end
