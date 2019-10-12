defmodule Camping.Repo.Migrations.Questions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add(:position, :integer)
      add(:question_desc, :string)
      add(:required, :boolean)

      timestamps()
    end
  end
end
