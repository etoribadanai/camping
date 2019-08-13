defmodule Camping.Trails do
  import Ecto.Query, warn: false
  alias Camping.Repo
  alias Camping.Trails.Schemas.Trail

  @doc """
  Returns the list of trails.

  ## Examples

      iex> list_trails()
      [%Trail{}, ...]

  """
  def list_trails() do
    Repo.all(Trail)
  end

  @doc """
  Gets a single trail.

  Raises `Ecto.NoResultsError` if the trail does not exist.

  ## Examples

      iex> get_trail(123)
      %Trail{}

      iex> get_trail(456)
      ** (Ecto.NoResultsError)

  """
  def get_trail(id), do: Repo.get(Trail, id)

  @doc """
  Create or update trails in db

  ## Examples

      iex> create_all_trail(%{field: value})
      {:ok, %Trail{}}

  """
  def create_or_update_trail(trail) do
    case Repo.get_by(Trail, id: trail.id) do
      nil -> Trail.changeset(%Trail{}, trail)
      trail_db -> Trail.changeset(trail_db, trail)
    end
    |> Repo.insert_or_update()
  end

  @doc """
  Deletes a Trail.

  ## Examples

      iex> delete_trail(trail)
      {:ok, %Trail{}}

      iex> delete_trail(trail)
      {:error, %Ecto.Changeset{}}

  """
  def delete_trail(%Trail{} = trail) do
    Repo.delete(trail)
  end
end
