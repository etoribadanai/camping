defmodule CampingWeb.PageController do
  use CampingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
