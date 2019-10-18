defmodule CampingWeb.CustomerAnswerController do
  use CampingWeb, :controller

  alias Camping.Accounts
  alias Camping.Accounts.Schemas.CustomerAnswer
  alias Camping.Quiz
  alias Camping.Accounts.CustomerAnswer.CreateOrUpdateHandler
  alias Camping.Accounts.Schemas.Customer
  alias Camping.Quiz.Schemas.Question
  alias Camping.Quiz.Schemas.Option

  action_fallback CampingWeb.FallbackController

  def create_or_update(conn, params) do
    with %Customer{} <- customer = Camping.Accounts.get_customer(params["customer_id"]),
         %Question{} <- question = Quiz.get_question(params["question_id"]),
         %Option{} <- option = Quiz.get_option(params["option_id"]),
         {:ok, customer_answer} <- CreateOrUpdateHandler.execute(params) do
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
