defmodule CampingWeb.OrderController do
  use CampingWeb, :controller

  alias Camping.Orders
  alias Camping.Accounts
  alias Camping.Accounts.Schemas.User

  def index(conn, _params) do
    orders = Orders.list_order()
    json(conn, %{data: orders})
  end

  def show(conn, %{"id" => id}) do
    order = Orders.get_order!(id)
    json(conn, %{data: order})
  end

  def create(conn, %{"order" => order_params}) do
    [token | _tail] = get_req_header(conn, "authorization")

    with %User{} = user <- Accounts.get_by(token: token) do
      # create order
    end
  end
end
