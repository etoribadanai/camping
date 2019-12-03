defmodule Camping.Accounts.Social.HandleCreate do
  alias Camping.Accounts
  alias Camping.Accounts.Social.HandleUpdate

  def create(params) do
    Accounts.get_social_by(email: params["email"])
    |> handle_user_registered(params)
  end

  defp handle_user_registered(_user = nil, params) do
    params
    |> Accounts.create_customer()
    |> handle_create_customer(params)
  end

  defp handle_user_registered(user, params), do: HandleUpdate.update(user, params)

  defp handle_create_customer({:error, _customer}, params) do
    {:error, "Error created customer #{params.email}"}
  end

  defp handle_create_customer({:ok, customer}, params) do
    params
    |> Map.put("customer_id", customer.id)
    |> valid_token(params["token"])
    |> create_social_login
  end

  defp create_social_login(social_params) do
    social_params
    |> Accounts.create_social_login()
  end

  defp valid_token(params, token) do
    case token == nil || token == "" do
      true -> params |> Map.put("token", generate_token())
      _ -> params
    end
  end

  defp generate_token(length \\ 80) do
    :crypto.strong_rand_bytes(length)
    |> Base.encode64()
    |> binary_part(0, length)
  end
end
