defmodule CampingWeb.TagController do
  use CampingWeb, :controller

  alias Camping.Tags

  def index(conn, _params) do
    tags = Tags.list_tags()
    render(conn, "index.json", tags: tags)
  end

  def create(conn, %{"tag" => tag_params}) do
    with {:ok, _tag} <- Tags.create_tag(tag_params) do
      json(conn, %{message: "Tag created successfully."})
    end
  end
end
