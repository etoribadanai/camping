defmodule CampingWeb.TrailController do
  use CampingWeb, :controller

  alias Camping.Trails

  def index(conn, _params) do
    trails = Trails.list_trails()
    render(conn, "index.json", trails: trails)
  end

  def create(conn, %{"trail_tag_option" => params}) do
    with {:ok, trail_tag_option} <- Trails.create_trail_tag_option(params) do
      json(conn, %{message: "Trail_id: #{trail_tag_option.id} created successfully."})
    end
  end

  def show(conn, %{"id" => id}) do
    trail = Trails.get_trail(id)
    render(conn, "show.json", trail: trail)
  end
end
