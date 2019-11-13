defmodule Camping.Accounts.User.HandleResetPassword do
  alias Camping.Accounts
  alias Camping.Accounts.Schemas.User
  alias Camping.Accounts.Schemas.Social
  alias Camping.Email.Integrations.SparkPost
  import Bamboo.Email

  def execute(email) do
    email
    |> get_user()
    |> valid_user()
  end

  defp get_user(email) do
    Accounts.get_user_by(email: email)
    |> handle_response_user(email)
  end

  defp handle_response_user(_user = nil, email), do: Accounts.get_social_by(email: email)
  defp handle_response_user(user, _email), do: user

  defp valid_user(%Social{} = user), do: {:error, "This user has a social login"}
  defp valid_user(%User{} = user), do: reset_password(user)
  defp valid_user(user = nil), do: {:error, "There is no user with this email"}

  defp is_user?(email) do
    with %User{} = user <- Accounts.get_user_by(email: email) do
      user
    end
  end

  defp is_social?(email) do
    with %Social{} = social <- Accounts.get_social_by(email: email) do
      social
    end
  end

  defp reset_password(user, length \\ 10) do
    :crypto.strong_rand_bytes(length)
    |> Base.encode64()
    |> binary_part(0, length)
    |> IO.inspect()
    |> save_new_password(user)
  end

  # "KZPFTtOv5M"
  def save_new_password(password, user), do: Accounts.update_password(user, %{password: password})

  defp send_new_password(user_data) do
    Agent.start(fn ->
      SparkPost.send_email(
        Accounts.get_customer(user_data.customer_id).name,
        user_data.email,
        System.get_env("RECOVER_PASSWORD_TEMPLATE_ID"),
        %{senha: user_data.password},
        ["recuperar senha"]
      )
    end)
  end

  def send(user_data) do
    %{
      to: user_data.email,
      subject: "Nova senha - Trilhas",
      body: format_body(user_data.password)
    }
    |> format()
    |> Camping.Email.Mailer.deliver_now()
  end

  defp format(options) do
    new_email(
      to: "etoribadanai@gmail.com",
      from: "etoribadanai@gmail.com",
      subject: options.subject,
      html_body: options.body
    )
  end

  defp format_body(password) do
    """
      <p>Olá</p>
      <p> Conforme solicitado, segue nova senha de acesso  à Trilhas:</p>
      <p>#{password}</p>
    """
  end
end
