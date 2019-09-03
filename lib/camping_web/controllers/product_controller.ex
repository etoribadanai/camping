defmodule CampingWeb.ProductController do
  use CampingWeb, :controller

  alias Camping.Products

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product_tag_option" => params}) do
    with {:ok, product_tag_option} <- Products.create_product_tag_option(params) do
      json(conn, %{message: "Productid: #{product_tag_option.id} created successfully."})
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product(id)
    render(conn, "show.json", product: product)
  end
end
