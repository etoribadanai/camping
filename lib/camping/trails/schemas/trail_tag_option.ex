defmodule Camping.Trails.Schemas.TrailTagOption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trail_tag_options" do
    field :trail_id, :integer
    field :tag_id, :id
    field :tag_option_id, :id

    timestamps()
  end

  @doc false
  def changeset(trail_tag_options, attrs) do
    trail_tag_options
    |> cast(attrs, [:trail_id, :tag_id, :tag_option_id])
    |> validate_required([:trail_id, :tag_id, :tag_option_id])
  end
end
