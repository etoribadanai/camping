defmodule Camping.Quiz.Schemas.Option do
  use Ecto.Schema
  import Ecto.Changeset

  schema "options" do
    field :active, :boolean, default: true
    field :position, :integer
    field :option, :string

    belongs_to(:question, Camping.Quiz.Schemas.Question)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(option, attrs) do
    option
    |> cast(attrs, [:option, :position, :active, :question_id])
    |> validate_required([:option, :position, :active, :question_id])
  end
end
