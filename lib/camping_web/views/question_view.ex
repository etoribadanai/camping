defmodule CampingWeb.QuestionView do
  use CampingWeb, :view
  alias CampingWeb.QuestionView

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, QuestionView, "question.json")}
  end

  def render("show.json", %{question: question}) do
    %{data: render_one(question, QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    %{
      question_desc: question.question_desc,
      position: question.position,
      required: question.required
    }
  end
end
