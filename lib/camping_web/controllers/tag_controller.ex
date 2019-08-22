defmodule CampingWeb.TagController do
  use CampingWeb, :controller

  alias Camping.Tags

  def index(conn, _params) do
    tags = Tags.list_tags()
    render(conn, "index.json", tags: tags)
  end

  def create(conn, %{"tag" => tag_params}) do
    with {:ok, tag} <- Tags.create_tag(tag_params) do
      json(conn, %{message: "Tag: #{tag.name} created successfully."})
    end
  end

  def create(conn, %{"tag_option" => tag_option_params}) do
    with {:ok, tag_option} <- Tags.create_tag_option(tag_option_params) do
      json(conn, %{message: "Tag Option value: #{tag_option.value} created successfully."})
    end
  end
end
