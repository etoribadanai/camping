defmodule CampingWeb.SocialController do
  use CampingWeb, :controller

  alias Camping.Accounts
  alias Camping.Accounts.Schemas.Social
  alias Camping.Accounts.Schemas.Customer
  alias Camping.Guardian

  action_fallback CampingWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Customer{} = customer} <- Accounts.create_customer(params),
         {:ok, %Social{} = social} <- Accounts.create_social_login(customer.id, params) do
      conn |> render("token.json", token: params["token"])
    end
  end
end
