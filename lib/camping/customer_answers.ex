defmodule Camping.CustomerAnswers do
  @moduledoc """
  The Customer Answers context.
  """

  import Ecto.Query, warn: false
  alias Camping.Repo
  alias Camping.Accounts.Schemas.CustomerAnswer
  alias Camping.Quiz.Schemas.Option
  alias Camping.Quiz.Schemas.Question

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

  def list(customer_id, details) do
    CustomerAnswer
    |> join(:inner, [ca], o in Option,
      on: ca.option_id == o.id and ca.question_id == o.question_id
    )
    |> where([ca, o], ca.customer_id == ^customer_id)
    |> select_fields(details)
    |> Repo.all()
  end

  defp select_fields(query, _details = false), do: query |> select([ca, o], o.id)

  defp select_fields(query, _details = true),
    do: query |> select([ca, o], %{question_id: ca.question_id, option_id: o.id})

  def count_required_answered(customer_id) do
    questions_required = question_required()

    customer_answered =
      from e in subquery(customer_answered(customer_id)),
        select: count(e.customer_id),
        group_by: e.customer_id

    Repo.all(customer_answered)
    |> List.first()
    |> percent_answered(questions_required)
  end

  defp customer_answered(customer_id) do
    CustomerAnswer
    |> join(:inner, [ca], q in Question, on: q.id == ca.question_id)
    |> where([ca, q], ca.selected == true)
    |> where([ca, q], q.required == true)
    |> where([ca, q], ca.customer_id == ^customer_id)
    |> select([ca, q], %{
      customer_id: ca.customer_id,
      question_id: ca.question_id
    })
    |> group_by([ua, q], [
      ua.customer_id,
      ua.question_id
    ])
  end

  defp question_required do
    Question
    |> join(:inner, [q], o in Option, on: q.id == o.question_id)
    |> where([q, o], q.required == true)
    |> group_by([q, _o], q.id)
    |> select([q, _o], q.id)
    |> Repo.all()
    |> length
  end

  defp percent_answered(_count = nil, _question_required), do: %{percent: 0}
  defp percent_answered(_count = question_required, question_required), do: %{percent: 100}

  defp percent_answered(count, question_required),
    do: %{percent: trunc(count / question_required * 100)}
end
