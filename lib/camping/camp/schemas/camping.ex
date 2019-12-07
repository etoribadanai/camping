defmodule Camping.Camp.Schemas.Camping do
  use Ecto.Schema
  import Ecto.Changeset

  schema "campings" do
    field :name, :string
    field :state, :string
    field :city, :string
    field :distance_from_capital, :float
    field :description, :string, size: 1000
    field :latitude, :float
    field :longitude, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(camping, attrs) do
    camping
    |> cast(attrs, [
      :name,
      :state,
      :city,
      :distance_from_capital,
      :description,
      :latitude,
      :longitude
    ])
    |> validate_required([:name, :state, :city, :description])
  end
end
