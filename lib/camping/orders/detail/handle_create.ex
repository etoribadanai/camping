defmodule Camping.Orders.Detail.HandleCreate do
  alias Camping.OrderDetails

  def create(params) do
    execute_create(params)
  end

  defp execute_create(params) do
    OrderDetails.create(params)
    |> handle_create()
  end

  defp handle_create({:error, msg}), do: {:error, msg}
  defp handle_create({:ok, order_detail}), do: {:ok, order_detail}
end
