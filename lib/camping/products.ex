defmodule Camping.Products do
  import Ecto.Query, warn: false
  alias Camping.Repo
  alias Camping.Products.Schemas.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products() do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product(123)
      %Product{}

      iex> get_product(456)
      ** (Ecto.NoResultsError)

  """
  def get_product(id), do: Repo.get(Product, id)

  @doc """
  Create or update products in db

  ## Examples

      iex> create_all_product(%{field: value})
      {:ok, %Product{}}

  """
  def create_or_update_product(product) do
    case Repo.get_by(Product, code: product.code) do
      nil -> Product.changeset(%Product{}, product)
      product_db -> Product.changeset(product_db, product)
    end
    |> Repo.insert_or_update()
  end

  @doc """
  Deletes a Product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end
end