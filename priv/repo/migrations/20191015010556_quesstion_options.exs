defmodule Camping.Repo.Migrations.QuesstionOptions do
  use Ecto.Migration

  def change do
    create table(:options) do
      add :option, :string, null: false
      add :position, :integer, null: false
      add :active, :boolean, default: true, null: false
      add :question_id, references(:questions, on_delete: :delete_all)

      timestamps()
    end

    create index(:options, [:question_id])
  end
end
