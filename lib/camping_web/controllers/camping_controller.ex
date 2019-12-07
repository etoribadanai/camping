defmodule CampingWeb.CampingController do
  use CampingWeb, :controller

  import Camping.Plugs.RequestParams
  plug(:valid_filters, ~w(search) when action in [:index])

  alias Camping.Campings

  def index(conn, _params) do
    filters = conn.assigns.filters
    campings = Campings.list(filters)

    render(conn, "index.json", campings: campings)
  end

  def show(conn, %{"id" => id}) do
    camping = Campings.get(id)
    render(conn, "show.json", camping: camping)
  end

  def create(conn, %{"camping" => params}) do
    with {:ok, camping} <- Campings.create(params) do
      json(conn, %{message: "Camping_id: #{camping.id} created successfully."})
    else
      err ->
        conn
        |> put_status(:bad_request)
        |> json(%{data: %{message: "Something went wrong", details: err}})
    end
  end
end
