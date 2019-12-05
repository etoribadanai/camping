defmodule CampingWeb.UserController do
  use CampingWeb, :controller

  alias Camping.Accounts
  alias Camping.Accounts.Schemas.User
  alias Camping.Guardian
  alias Camping.Accounts.Schemas.Customer
  alias Camping.Accounts.Schemas.User
  alias Camping.Accounts.User.HandleResetPassword
  alias Camping.Accounts.User.HandleCreate

  # action_fallback CampingWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, params) do
    IO.inspect(%{name: params["name"], email: params["email"]}, label: "User create")

    with {:ok, response} <- HandleCreate.create(params) do
      json(conn, %{name: response.name, token: response.token})
    else
      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> json(%{data: %{message: msg}})
    end
  end

  def sign_in(conn, %{"value" => value, "password" => password}) do
    case Accounts.token_sign_in(value, password) do
      {:ok, token, name} ->
        json(conn, %{data: %{jwt: token, name: name}})

      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> json(%{data: %{message: msg}})
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
