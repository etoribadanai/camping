defmodule CampingWeb.CustomerController do
  use CampingWeb, :controller

  alias Camping.Accounts
  alias Camping.Accounts.Schemas.Customer
  alias Camping.Guardian

  action_fallback CampingWeb.FallbackController

  def index(conn, _params) do
    customers = Accounts.list_customers()
    render(conn, "index.json", customers: customers)
  end

  def create(conn, %{"customer" => customer_params}) do

    with {:ok, %Customer{} = customer} <- Accounts.create_customer(customer_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(customer) do
        #  {:ok, _} <- Accounts.store_token(customer, token) do
      conn |> render("jwt.json", jwt: token)
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token} ->
        conn |> render("jwt.json", jwt: token)

      _ ->
        {:error, :unauthorized}
    end
  end

  def show(conn, _params) do
    # Ajustar o retorno do user, esta retornando certo sempre se eu passo um token antigo ou novo
    # user = Guardian.Plug.current_resource(conn)
    # # [token | _tail] = get_req_header(conn, "authorization")

    # with {%User{} = user} <- Accounts.get_by(token: token) do
    #   conn |> render("user.json", user: user)
    # end
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
