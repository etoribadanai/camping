require IEx

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
      question: %{
        id: question.id,
        question_desc: question.question_desc,
        position: question.position,
        required: question.required,
        options: render_many(question.options, QuestionView, "option.json")
      }
    }
  end

  def render("option.json", %{question: option}) do
    %{
      question_id: option.question_id,
      option: option.option,
      id: option.id,
      position: option.position,
      active: option.active
    }
  end
end
