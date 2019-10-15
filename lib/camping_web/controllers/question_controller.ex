defmodule CampingWeb.QuestionController do
  use CampingWeb, :controller

  alias Camping.Questions
  alias Camping.Questions.Schemas.Question

  action_fallback CampingWeb.FallbackController

  def index(conn, _params) do
    questions = Questions.list_question()
    render(conn, "index.json", questions: questions)
  end

  def show(conn, %{"id" => id}) do
    question = Questions.get_question(id)
    render(conn, "show.json", question: question)
  end
end
