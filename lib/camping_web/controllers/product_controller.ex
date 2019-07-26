defmodule CampingWeb.ProductController do
  use CampingWeb, :controller

  alias Camping.Products

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, "index.json", products: products)
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product(id)
    render(conn, "show.json", product: product)
  end
end
