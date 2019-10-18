defmodule Camping.Quiz do
  @moduledoc """
  The Questions context.
  """
  import Ecto.Query, warn: false
  alias Camping.Repo
  alias Camping.Quiz.Schemas.Question
  alias Camping.Quiz.Schemas.Option

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
  Returns the list of questions with options.

  ## Examples

      iex> question_with_options()
      [%Question{}, ...]

  """
  def question_with_options do
    Question
    |> preload(:options)
    |> Repo.all()
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

  @doc """
  Gets a single option.

  Raises `Ecto.NoResultsError` if the Option does not exist.

  ## Examples

      iex> get_option(123)
      %Option{}

      iex> get_option(456)
      ** nil

  """
  def get_option(id), do: Repo.get(Option, id)
end
