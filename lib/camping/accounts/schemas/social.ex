defmodule Camping.Accounts.Schemas.Social do
  use Ecto.Schema
  import Ecto.Changeset

  schema "social_logins" do
    field :email, :string
    field :customer_id, :integer
    field :uid, :string
    field :image, :string
    field :provider, :string
    field :token, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(social, attrs) do
    social
    |> cast(attrs, [:email, :customer_id, :uid, :image, :provider, :token, :name])
    |> validate_required([:customer_id, :provider, :token])
    |> unique_constraint(:email, downcase: true)
  end
end
