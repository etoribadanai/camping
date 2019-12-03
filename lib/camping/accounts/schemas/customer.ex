defmodule Camping.Accounts.Schemas.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Camping.Accounts.Schemas.Customer

  schema "customers" do
    field :email, :string
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
    |> cast(attrs, [:email, :name, :cpf, :birth_date, :phone_area, :phone_number])
    # |> validate_required([:email])
    # |> validate_format(:email, ~r/@/)
    # |> unique_constraint(:email)
  end
end
