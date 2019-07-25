defmodule Camping.Orders.Schemas.Detail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders_details" do
    field :order_id, :id
    field :product_id, :id
    field :purchased, :boolean, default: true

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order_detail, attrs) do
    order_detail
    |> cast(attrs, [:order_id, :product_id, :purchased])
    |> validate_required([:order_id, :product_id])
  end
end
