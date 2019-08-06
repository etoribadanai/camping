defmodule Camping.Accounts.Social.HandleCreate do
  alias Camping.Accounts

  def create(params) do
    Accounts.get_social_by(email: params["email"])
    |> handle_user_registered(params)
  end

  defp handle_user_registered(_user = nil, params) do
    params
    |> Accounts.create_customer()
    |> handle_create_customer(params)
  end

  defp handle_user_registered(user, params) do
    Camping.Accounts.Social.HandleUpdate.update(user, params)
  end

  defp handle_create_customer({:error, _customer}, params), do: {:error, "Error created customer #{params.email}"}

  defp handle_create_customer({:ok, customer}, params) do
    Map.put(params, "customer_id", customer.id)
    |> create_social_login
  end

  defp create_social_login(social_params) do
    social_params
    |> Accounts.create_social_login()
  end
end
