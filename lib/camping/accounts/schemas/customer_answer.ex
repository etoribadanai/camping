defmodule Camping.Accounts.Schemas.CustomerAnswer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Camping.Accounts.Schemas.CustomerAnswer

  schema "customer_answers" do
    field :customer_id, :id
    field :question_id, :id
    field :option_id, :id
    field :selected, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%CustomerAnswer{} = customer_answer, attrs) do
    customer_answer
    |> cast(attrs, [:customer_id, :question_id, :option_id, :selected])
    |> validate_required([:customer_id, :question_id, :option_id])
  end
end
