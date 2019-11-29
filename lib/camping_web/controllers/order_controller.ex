defmodule CampingWeb.OrderController do
  use CampingWeb, :controller

  alias Camping.Orders
  alias Camping.Orders.Order.HandleCreate
  alias Camping.Accounts.Schemas.Customer
  alias Camping.Guardian

  def index(conn, _params) do
    orders = Orders.list_order()
    render(conn, "index.json", orders: orders)
  end

  def create(conn, params) do
    IO.inspect(params |> Map.put(:customer_id, conn.assigns.signed_user.customer_id),
      label: "Order created"
    )

    params
    |> HandleCreate.create(conn.assigns.signed_user.customer_id)
    |> handle_create_order(conn)
  end

  defp handle_create_order({:ok, order}, conn), do: json(conn, %{order_id: order.id})
  defp handle_create_order({:error, msg}, conn), do: json(conn, %{message: msg})

  def show(conn, %{"id" => id}) do
    order = Orders.get_order(id)
    render(conn, "show.json", order: order)
  end
end
