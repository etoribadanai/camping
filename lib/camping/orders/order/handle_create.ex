defmodule Camping.Orders.Order.HandleCreate do
  alias Camping.Orders
  alias Camping.Orders.Detail.HandleCreate

  def create(params, customer_id) do
    params
    |> Map.put("customer_id", customer_id)
    |> execute_create()
  end

  defp execute_create(params) do
    with response = {:ok, order} <-
           Orders.create_order(%{obs: params["obs"], customer_id: params["customer_id"]}) do
      create_order_details(order.id, params["products_ids"])

      response
    end
  end

  defp create_order_details(order_id, products_ids) do
    Enum.map(products_ids, fn product_id ->
      HandleCreate.create(%{order_id: order_id, product_id: product_id})
    end)
  end
end
