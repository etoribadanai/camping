defmodule Camping.Products.Schemas.ProductTagOption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_tag_options" do
    field :product_id, :integer
    field :tag_id, :id
    field :tag_option_id, :id

    timestamps()
  end

  @doc false
  def changeset(product_tag_option, attrs) do
    product_tag_option
    |> cast(attrs, [:product_id, :tag_id, :tag_option_id])
    |> validate_required([:product_id, :tag_id, :tag_option_id])
  end
end
