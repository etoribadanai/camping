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

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
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
      :nearby
    ])
  end
end
