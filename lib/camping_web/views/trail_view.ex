defmodule CampingWeb.TrailView do
  use CampingWeb, :view
  alias CampingWeb.TrailView

  def render("index.json", %{trails: trails}) do
    %{data: render_many(trails, TrailView, "trail.json")}
  end

  def render("show.json", %{trail: trail}) do
    %{data: render_one(trail, TrailView, "trail.json")}
  end

  def render("trail.json", %{trail: trail}) do
    %{
      id: trail.id,
      name: trail.name,
      state: trail.state,
      city: trail.city,
      level: trail.level,
      distance: trail.distance,
      duration: trail.duration,
      distance_from_capital: trail.distance_from_capital,
      start: trail.start,
      finish: trail.finish,
      nearby: trail.nearby,
      description: trail.description
    }
  end
end
