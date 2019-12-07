defmodule CampingWeb.CampingView do
  use CampingWeb, :view
  alias CampingWeb.CampingView

  def render("index.json", %{campings: campings}) do
    %{data: render_many(campings, CampingView, "camping.json")}
  end

  def render("show.json", %{camping: camping}) do
    %{data: render_one(camping, CampingView, "camping.json")}
  end

  def render("camping.json", %{camping: camping}) do
    %{
      id: camping.id,
      name: camping.name,
      state: camping.state,
      city: camping.city,
      distance_from_capital: camping.distance_from_capital,
      description: camping.description,
      latitude: camping.latitude,
      longitude: camping.longitude
    }
  end
end
