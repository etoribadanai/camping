defmodule Camping.Tags do
  @moduledoc """
  The Tag context.
  """

  import Ecto.Query, warn: false
  alias Camping.Repo
  alias Camping.Tags.Schemas.Tag

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tags{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Creates a Tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    case tag = Repo.get_by(Tag, name: attrs["name"]) do
      nil ->
        tag_created =
          %Tag{}
          |> Tag.changeset(attrs)
          |> Repo.insert()

        tag_created

      _ ->
        {:ok, tag}
    end
  end
end
