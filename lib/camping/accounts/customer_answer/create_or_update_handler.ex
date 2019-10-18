defmodule Camping.Accounts.CustomerAnswer.CreateOrUpdateHandler do
  alias Camping.CustomerAnswers

  def execute(
        params = %{
          "customer_id" => customer_id,
          "question_id" => question_id,
          "option_id" => option_id,
          "selected" => selected
        }
      ) do
    CustomerAnswers.create_or_update(params)
    |> handle_response()
  end

  defp handle_response(response = {:ok, customer_answer}), do: response
  defp handle_response(response = {:error, _customer_answer}), do: response
end
