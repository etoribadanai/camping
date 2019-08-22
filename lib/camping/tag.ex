defmodule Camping.Tags do
  @moduledoc """
  The Tag context.
  """

  import Ecto.Query, warn: false
  alias Camping.Repo
  alias Camping.Tags.Schemas.Tag
  alias Camping.Tags.Schemas.TagOption

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

  @doc """
  Creates a Tag Option.

  ## Examples

      'iex'> create_tag_option(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag_option(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag_option(attrs \\ %{}) do
    case tag_option = Repo.get_by(TagOption, tag_id: attrs["tag_id"], value: attrs["value"]) do
      nil ->
        tag_option_created =
          %TagOption{}
          |> TagOption.changeset(attrs)
          |> Repo.insert()

        tag_option_created

      _ ->
        {:ok, tag_option}
    end
  end
end
