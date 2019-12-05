defmodule Camping.Accounts.User.HandleCreate do
  alias Camping.Accounts
  alias Camping.Accounts.Schemas.User
  alias Camping.Guardian
  alias Camping.Accounts.Schemas.Customer
  alias Camping.Accounts.Schemas.User
  alias Camping.Repo

  def create(params) do
    is_valid?(params["email"])
    |> handle_valid(params)
  end

  defp is_valid?(email), do: String.contains?(email, "@")

  defp handle_valid(_valid = false, params),
    do: {:error, "email: #{params["email"]} is not valid"}

  defp handle_valid(_valid = true, params) do
    email_registered(params["email"])
    |> handle_registered(params)
  end

  defp email_registered(email) do
    case Repo.get_by(User, email: String.downcase(email)) do
      nil -> false
      user -> true
    end
  end

  defp handle_registered(_registered = false, params) do
    with {:ok, %Customer{} = customer} <- Accounts.create_customer(params),
         {:ok, %User{} = user} <- Accounts.create_user(customer.id, params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user),
         {:ok, _} <- Accounts.store_token(user, token) do
      {:ok, %{name: customer.name, token: token}}
    end
  end

  defp handle_registered(_registered = true, _params),
    do: {:error, "Email has already taken or not passed"}
end
