defmodule CampingWeb.QuestionController do
  use CampingWeb, :controller

  alias Camping.Questions
  alias Camping.Questions.Schemas.Question

  action_fallback CampingWeb.FallbackController

  def index(conn, _params) do
    orders = Questions.list_question()
    render(conn, "index.json", orders: orders)
  end

  def show(conn, %{"id" => id}) do
    order = Orders.get_order(id)
    render(conn, "show.json", order: order)
  end
end
