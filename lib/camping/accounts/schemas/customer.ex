defmodule Camping.Accounts.Schemas.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Camping.Accounts.Schemas.Customer

  schema "customers" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Customer{} = customer, attrs) do
    customer
    |> cast(attrs, [:email, :name])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
