defmodule Camping.OrderDetails do
  import Ecto.Query, warn: false
  alias Camping.Repo

  alias Camping.Orders.Schemas.Detail
  alias Camping.Orders.Schemas.Order

  @doc """
  Creates a order detail.

  ## Examples

      iex> create(%{field: value})
      {:ok, %OrderDetail{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Detail{}
    |> Detail.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order detail.

  ## Examples

      iex> update(order_detail, %{field: new_value})
      {:ok, %OrderDetail{}}

      iex> update(order_detail, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Detail{} = order_detail, attrs) do
    order_detail
    |> Detail.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Get all orders details based on customer_id and order_id

  return [] if the User has no orders detail.

  ## Examples

      iex> list_orders_details(1, customer_id)
      %Order{}

      iex> list_orders_details(0, customer_id)
      []
  """
  def list_orders_details(order_id, user_id) do
    query =
      from(od in Detail,
        join: o in Order,
        on: od.order_id == o.id,
        where:
          o.user_id == ^user_id and
            od.order_id == ^order_id
      )

    Repo.all(query)
  end
end
