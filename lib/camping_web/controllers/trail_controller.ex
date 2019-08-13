defmodule CampingWeb.TrailController do
  use CampingWeb, :controller

  alias Camping.Trails

  def index(conn, _params) do
    trails = Trails.list_trails()
    render(conn, "index.json", trails: trails)
  end

  def show(conn, %{"id" => id}) do
    trail = Trails.get_trail(id)
    render(conn, "show.json", trail: trail)
  end
end
