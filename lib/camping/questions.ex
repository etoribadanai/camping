defmodule Camping.Questions do
  @moduledoc """
  The Questions context.
  """
  import Ecto.Query, warn: false
  alias Camping.Repo
  alias Camping.Questions.Schemas.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_question()
      [%Order{}, ...]

  """
  def list_question do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question(123)
      %Question{}

      iex> get_question(456)
      ** nil

  """
  def get_question(id), do: Repo.get(Question, id)
end
