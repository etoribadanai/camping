defmodule CampingWeb.QuestionController do
  use CampingWeb, :controller

  alias Camping.Quiz
  alias Camping.Quiz.Schemas.Question

  action_fallback CampingWeb.FallbackController

  def index(conn, _params) do
    questions = Quiz.question_with_options()
    render(conn, "index.json", questions: questions)
  end

  def show(conn, %{"id" => id}) do
    question = Quiz.get_question(id)
    render(conn, "show.json", question: question)
  end
end
