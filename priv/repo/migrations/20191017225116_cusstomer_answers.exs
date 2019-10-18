defmodule Camping.Repo.Migrations.CusstomerAnswers do
  use Ecto.Migration

  def change do
    create table(:customer_answers) do
      add(:selected, :boolean)
      add(:customer_id, references(:customers, on_delete: :delete_all))
      add(:question_id, references(:questions, on_delete: :delete_all))
      add(:option_id, references(:options, on_delete: :delete_all))

      timestamps()
    end

    create(index(:customer_answers, [:customer_id]))
    create(index(:customer_answers, [:question_id]))
    create(index(:customer_answers, [:option_id]))
  end
end
