defmodule CampingWeb.SocialController do
  use CampingWeb, :controller

  alias Camping.Accounts.Schemas.Social
  alias Camping.Accounts.Social.HandleCreate

  action_fallback CampingWeb.FallbackController

  # def create(conn, params) do
  #   with {:ok, %Customer{} = customer} <- Accounts.create_customer(params),
  #        {:ok, %Social{} = social} <- Accounts.create_social_login(customer.id, params) do
  #     conn |> render("token.json", token: params["token"])
  #   end
  # end

  def create(conn, params) do
    IO.inspect(params, label: "Social create or update")

    with {:ok, %Social{} = user} <- HandleCreate.create(params) do
      json(conn, %{name: user.name, token: user.token, admin: user.admin, msg: "APP em desenvolvimento"})
    else
      err ->
        conn
        |> put_status(:bad_request)
        |> json(%{data: %{message: "Something went wrong to create user #{params["email"]}"}})
    end
  end
end
