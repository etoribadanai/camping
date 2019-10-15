defmodule Camping.Quiz.Schemas.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :position, :integer
    field :question_desc, :string
    field :required, :boolean

    has_many(:options, Camping.Quiz.Schemas.Option)
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [
      :position,
      :question_desc,
      :required
    ])
  end
end
