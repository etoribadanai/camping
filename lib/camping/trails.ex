defmodule Camping.Trails do
  import Ecto.Query, warn: false
  alias Camping.Repo
  alias Camping.Trails.Schemas.Trail
  alias Camping.Trails.Schemas.TrailTagOption
  alias Camping.Tags.Schemas.Tag
  alias Camping.CustomerAnswers
  alias Camping.Trails.Schemas.TrailOption

  @doc """
  Returns the list of trails.

  ## Examples

      iex> list_trails()
      [%Trail{}, ...]

  """
  def list_trails(filters) do
    Trail
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
    |> group_by([t], [t.id, t.state, t.city])
  end

  def list_trails_to_customer(customer_id) do
    CustomerAnswers.list(customer_id, false)
    |> build_search_query()
  end

  defp build_search_query([kind | options]) do
    TrailOption
    |> join(:inner, [to], t in Trail, on: t.id == to.trail_id)
    |> where([to, t], t.kind == ^kind)
    |> where([to, t], to.option_id in ^options)
    |> select([to, t], t)
    |> group_by([to, t], [to.trail_id, t.name, t.id])
    |> Repo.all()
  end

  defp build_search_query([]), do: []

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
  # def create_or_update_trail(trail) do
  #   case Repo.get_by(Trail, id: trail["id"]) do
  #     nil -> Trail.changeset(%Trail{}, trail)
  #     trail_db -> Trail.changeset(trail_db, trail)
  #   end
  #   |> Repo.insert_or_update()
  # end

  @doc """
  Creates a trail.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Trail{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Trail{}
    |> Trail.changeset(attrs)
    |> Repo.insert()
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

  @doc """
  Creates a product tag option.

  ## Examples

      iex> create_product_tag_option(%{field: value})
      {:ok, %Product{}}

      iex> create_product_tag_option(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_trail_tag_option(attrs \\ %{}) do
    case Repo.get_by(TrailTagOption,
           tag_id: attrs["tag_id"],
           trail_id: attrs["trail_id"]
         ) do
      nil ->
        TrailTagOption.changeset(%TrailTagOption{}, attrs)

      trail_tag_value_db ->
        TrailTagOption.changeset(trail_tag_value_db, attrs)
    end
    |> Repo.insert_or_update()
  end
end
