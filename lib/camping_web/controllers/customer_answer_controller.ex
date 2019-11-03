defmodule CampingWeb.CustomerAnswerController do
  use CampingWeb, :controller

  alias Camping.Quiz
  alias Camping.Accounts.CustomerAnswer.CreateOrUpdateHandler
  alias Camping.Quiz.Schemas.Question
  alias Camping.Quiz.Schemas.Option

  action_fallback(CampingWeb.FallbackController)

  def create_or_update(conn, params) do
    with %Question{} <- _question = Quiz.get_question(params["question_id"]),
         %Option{} <- _option = Quiz.get_option(params["option_id"]),
         {:ok, _customer_answer} <-
           CreateOrUpdateHandler.execute(
             Map.put(params, "customer_id", conn.assigns.signed_user.customer_id)
           ) do
      conn
      |> put_status(:created)
      |> json(%{data: %{message: "Customer answer created or updated successfully"}})
    else
      err ->
        conn
        |> put_status(:bad_request)
        |> json(%{data: %{message: "Something went wrong", details: err}})
    end
  end
end
