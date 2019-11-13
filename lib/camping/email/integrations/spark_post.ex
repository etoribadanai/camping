defmodule Camping.Email.Integrations.SparkPost do
  @moduledoc """
    Integration to spark post that is resposible to send the emails
  """
  use Tesla

  plug Tesla.Middleware.Timeout, timeout: 6_000
  plug Tesla.Middleware.BaseUrl, System.get_env("SPARK_POST_URL")
  plug Tesla.Middleware.JSON

  plug Tesla.Middleware.Headers, [
    {"Content-Type", "application/json"},
    {"Authorization", System.get_env("SPARK_POST_TOKEN")}
  ]

  def send_email(customer_name, email, template_id, substitution_data, tags \\ nil) do
    body =
      Camping.Email.Body.SparkPost.format(
        customer_name,
        email,
        template_id,
        substitution_data,
        tags
      )

    "transmissions?num_rcpt_errors=3"
    |> post(body)
  end
end
