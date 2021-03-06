require IEx

defmodule CampingWeb.TrailController do
  use CampingWeb, :controller

  import Camping.Plugs.RequestParams
  plug :valid_filters, ~w(search) when action in [:index]

  alias Camping.Trails

  def index(conn, %{"customer" => "true"}) do
    trails = Trails.list_trails_to_customer(conn.assigns.signed_user.customer_id)
    render(conn, "index.json", trails: trails)
  end

  def index(conn, _params) do
    filters = conn.assigns.filters

    trails = Trails.list_trails(filters)
    render(conn, "index.json", trails: trails)
  end

  def create(conn, %{"trail" => params}) do
    with {:ok, trail} <- Trails.create(params) do
      json(conn, %{message: "Trail_id: #{trail.id} created successfully."})
    else
      err ->
        conn
        |> put_status(:bad_request)
        |> json(%{data: %{message: "Something went wrong", details: err}})
    end
  end

  def create(conn, %{"trail_tag_option" => params}) do
    with {:ok, trail_tag_option} <- Trails.create_trail_tag_option(params) do
      json(conn, %{message: "Trail_id: #{trail_tag_option.id} created successfully."})
    else
      err ->
        conn
        |> put_status(:bad_request)
        |> json(%{data: %{message: "Something went wrong", details: err}})
    end
  end

  def show(conn, %{"id" => id}) do
    trail = Trails.get_trail(id)
    render(conn, "show.json", trail: trail)
  end
end
