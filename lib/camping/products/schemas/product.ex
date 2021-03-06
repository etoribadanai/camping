defmodule Camping.Products.Schemas.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :code, :integer
    field :name, :string
    field :description, :string
    field :category, :string
    field :brand, :string
    field :obs, :string
    field :stock, :integer
    field :image, :string
    field :price, :float
    field :level, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :code,
      :name,
      :description,
      :category,
      :brand,
      :obs,
      :stock,
      :image,
      :price,
      :level
    ])
  end
end
