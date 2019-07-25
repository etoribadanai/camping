defmodule Camping.Products.Schemas.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :code, :integer
    field :description, :string
    field :brand, :string
    field :obs, :string
    field :stock, :integer
    field :image, :string
    field :price, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :code,
      :description,
      :brand,
      :obs,
      :stock,
      :image,
      :price
    ])
  end
end
