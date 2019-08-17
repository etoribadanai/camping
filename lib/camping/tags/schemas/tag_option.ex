defmodule Camping.Tags.Schemas.TagOption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tag_options" do
    field :values, :string
    field :tag_id, :id

    timestamps()
  end

  @doc false
  def changeset(tag_option, attrs) do
    tag_option
    |> cast(attrs, [:values, :tag_id])
    |> validate_required([:values, :tag_id])
  end
end
