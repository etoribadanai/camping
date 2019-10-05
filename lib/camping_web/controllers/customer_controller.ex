defmodule CampingWeb.CustomerController do
  use CampingWeb, :controller

  alias Camping.Accounts
  alias Camping.Accounts.Schemas.Customer

  action_fallback CampingWeb.FallbackController

  def index(conn, _params) do
    customers = Accounts.list_customers()
    render(conn, "index.json", customers: customers)
  end

  def show(conn, %{"id" => id}) do
    customer = Accounts.get_customer(id)
    conn |> render("customer.json", customer: customer)
  end

  def update(conn, %{"id" => id, "customer" => customer_params}) do
    customer = Accounts.get_customer!(id)

    with {:ok, %Customer{} = customer} <- Accounts.update_customer(customer, customer_params) do
      render(conn, "show.json", customer: customer)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Accounts.get_customer!(id)

    with {:ok, %Customer{}} <- Accounts.delete_customer(customer) do
      send_resp(conn, :no_content, "")
    end
  end
end
