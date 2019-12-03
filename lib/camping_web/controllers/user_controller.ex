defmodule CampingWeb.UserController do
  use CampingWeb, :controller

  alias Camping.Accounts
  alias Camping.Accounts.Schemas.User
  alias Camping.Guardian
  alias Camping.Accounts.Schemas.Customer
  alias Camping.Accounts.Schemas.User
  alias Camping.Accounts.User.HandleResetPassword

  # action_fallback CampingWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, params) do
    IO.inspect(%{name: params["name"], email: params["email"]}, label: "User create")
    # TODO verificar se email / CPF é valido
    # TODO verificar se o email ja foi cadastrado / CPF

    with {:ok, %Customer{} = customer} <- Accounts.create_customer(params),
         {:ok, %User{} = user} <- Accounts.create_user(customer.id, params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user),
         {:ok, _} <- Accounts.store_token(user, token) do
      json(conn, %{name: customer.name, token: token})
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, name} -> json(conn, %{data: %{jwt: token, name: name}})
      _ -> {:error, :unauthorized}
    end
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("user.json", user: user)
  end

  def reset_password(conn, %{"email" => email}) do
    IO.inspect(email, label: "User reset password")

    with {:ok, user} <- HandleResetPassword.execute(email) do
      json(conn, %{data: %{message: "Reset Password updated successfully to: #{email}"}})
    else
      {:error, msg} -> json(conn, %{message: msg})
    end
  end
end
