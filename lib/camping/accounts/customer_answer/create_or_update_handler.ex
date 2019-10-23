defmodule Camping.Accounts.CustomerAnswer.CreateOrUpdateHandler do
  alias Camping.CustomerAnswers

  def execute(
        params = %{
          "customer_id" => _customer_id,
          "question_id" => _question_id,
          "option_id" => _option_id,
          "selected" => _selected
        }
      ) do
    params
    |> CustomerAnswers.create_or_update()
    |> handle_response()
  end

  defp handle_response(response = {:ok, customer_answer}), do: response
  defp handle_response(response = {:error, _customer_answer}), do: response
end
