defmodule Camping.Orders.Schemas.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :obs, :string, size: 1000
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [
      :obs,
      :user_id
    ])
    |> validate_required([:user_id])
  end
end
