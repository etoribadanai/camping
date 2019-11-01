defmodule Camping.Trails.Schemas.TrailOption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trail_options" do
    field :trail_id, :integer
    field :option_id, :id

    timestamps()
  end

  @doc false
  def changeset(trail_options, attrs) do
    trail_options
    |> cast(attrs, [:trail_id, :option_id])
    |> validate_required([:trail_id, :option_id])
  end
end
