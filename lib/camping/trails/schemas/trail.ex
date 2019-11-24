defmodule Camping.Trails.Schemas.Trail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trails" do
    field :name, :string
    field :state, :string
    field :city, :string
    field :level, :string
    field :distance, :float
    field :duration, :float
    field :distance_from_capital, :float
    field :start, :string
    field :finish, :string
    field :nearby, :string
    field :description, :string, size: 1000
    field :kind, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(trail, attrs) do
    trail
    |> cast(attrs, [
      :name,
      :state,
      :city,
      :level,
      :distance,
      :duration,
      :distance_from_capital,
      :start,
      :finish,
      :nearby,
      :description,
      :kind
    ])
  end
end
