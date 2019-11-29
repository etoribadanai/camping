defmodule Camping.Repo.Migrations.AddNewFieldsCustomersTable do
  use Ecto.Migration

  def change do
    alter table(:customers) do
      add :cpf, :string
      add :birth_date, :string
      add :phone_area, :string
      add :phone_number, :string
    end
  end
end
