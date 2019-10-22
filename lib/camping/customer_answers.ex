defmodule Camping.CustomerAnswers do
  @moduledoc """
  The Customer Answers context.
  """

  import Ecto.Query, warn: false
  alias Camping.Repo
  alias Camping.Accounts.Schemas.CustomerAnswer

  @doc """
  Create or update customer answer in db

  ## Examples

      iex> create_or_update_customer_answer([customer_id: customer_id, question_id: question_id, option_id: option_id, selected: selected])
      {:ok, %CustomerAnswer{}}

  """
  def create_or_update(params) do
    case Repo.get_by(CustomerAnswer,
           customer_id: params["customer_id"],
           question_id: params["question_id"],
           selected: params["selected"]
         ) do
      nil -> CustomerAnswer.changeset(%CustomerAnswer{}, params)
      customer_answer_db -> CustomerAnswer.changeset(customer_answer_db, params)
    end
    |> Repo.insert_or_update()
  end
end
