defmodule Camping.Campings do
  import Ecto.Query, warn: false
  alias Camping.Repo
  alias Camping.Camp.Schemas.Camping

  @doc """
  Returns the list of camping.

  ## Examples

      iex> list()
      [%Camping{}, ...]

  """
  def list(filters) do
    Camping
    |> filter(filters)
    |> group()
    |> Repo.all()
  end

  defp filter(query, filters) do
    Enum.reduce(filters, query, fn {key, value}, query ->
      value = String.trim(value)

      case String.downcase(key) do
        "search" ->
          build_search_query(query, value)

        _ ->
          query
      end
    end)
  end

  defp build_search_query(query, value) do
    query
    |> where([t], ilike(t.description, ^"%#{value}%"))
  end

  defp group(query) do
    query
    |> group_by([c], [c.id, c.state, c.city])
  end

  @doc """
  Gets a single camping.

  Raises `Ecto.NoResultsError` if the camping does not exist.

  ## Examples

      iex> get(123)
      %Camping{}

      iex> get(456)
      ** (Ecto.NoResultsError)

  """
  def get(id), do: Repo.get(Camping, id)
end
