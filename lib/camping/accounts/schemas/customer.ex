defmodule Camping.Accounts.Schemas.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Camping.Accounts.Schemas.Customer

  schema "customers" do
    field :name, :string
    field :cpf, :string
    field :birth_date, :string
    field :phone_area, :string
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(%Customer{} = customer, attrs) do
    customer
    |> cast(attrs, [:name, :cpf, :birth_date, :phone_area, :phone_number])
  end
end
