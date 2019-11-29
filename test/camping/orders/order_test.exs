defmodule OrderTest do
  use ExUnit.Case, async: true
  doctest CampingWeb.OrderController
  alias Camping.Orders.Order.HandleCreate
  alias Camping.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Camping.Repo)
  end

  @tag :mustexec
   describe "Order" do
    test "created when passed all fields and creates successfully" do
      customer = Factory.insert(:customer)
      prod1 = Factory.insert(:product)
      prod2 = Factory.insert(:product)

      {:ok, order} = HandleCreate.create(%{"obs" => "order test", "products_ids" => [prod1.id, prod2.id]}, customer.id)

      assert order != nil
      assert order.customer_id == customer.id
    end

    test "Do not create when not passed customer_id" do
      prod1 = Factory.insert(:product)
      prod2 = Factory.insert(:product)

      {:error, msg} = HandleCreate.create(%{"obs" => "order test", "products_ids" => [prod1.id, prod2.id]}, nil)

      assert msg.errors == [customer_id: {"can't be blank", [validation: :required]}]
    end
  end
end
