defmodule Camping.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Camping.Repo

  alias Camping.Accounts.Schemas.Customer
  alias Camping.Guardian
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  @doc """
  Returns the list of customers.

  ## Examples

      iex> list_customers()
      [%Customer{}, ...]

  """
  def list_customers do
    Repo.all(Customer)
  end

  @doc """
  Gets a single customer.

  Raises `Ecto.NoResultsError` if the customer does not exist.

  ## Examples

      iex> get_customer!(123)
      %Customer{}

      iex> get_customer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer!(id), do: Repo.get!(Customer, id)

  @doc """
  Gets a single customer based on passed fields

  Returns nil when customer doesn't exist.

  ## Examples

      iex> get_by([token: "12345678900"])
      %Customer{}

      iex> get_by([token: "123"])
      nil

  """
  def get_by(fields), do: Repo.get_by(Customer, fields)

  def token_sign_in(email, password) do
    with {:ok, customer} <- email_password_auth(email, password),
         {:ok, token, _claims} = Guardian.encode_and_sign(customer),
         {:ok, _} <- store_token(customer, token) do
      {:ok, token}
    else
      _ -> {:error, :unauthorized}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, customer} <- get_by_email(email),
         do: verify_password(password, customer)
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(Customer, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Login error."}

      customer ->
        {:ok, customer}
    end
  end

  defp verify_password(password, %Customer{} = customer) when is_binary(password) do
    if checkpw(password, customer.password_hash) do
      {:ok, customer}
    else
      {:error, :invalid_password}
    end
  end

  @doc """
  Returns an updated customer with new JWT stored in DB.

  ## Examples

      iex> store_token(customer, token)
      {:ok, %Customer{}}

  """
  # def store_token(%User{} = user, token) do
  #   user
  #   |> Ecto.Changeset.change(%{token: token})
  #   |> Repo.update()
  # end

  @doc """
  Creates a customer.

  ## Examples

      iex> create_customer(%{field: value})
      {:ok, %Customer{}}

      iex> create_customer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a customer.

  ## Examples

      iex> update_customer(customer, %{field: new_value})
      {:ok, %Customer{}}

      iex> update_customer(customer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_customer(%Customer{} = customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a customer.

  ## Examples

      iex> delete_customer(customer)
      {:ok, %Customer{}}

      iex> delete_customer(customer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_customer(%Customer{} = customer) do
    Repo.delete(customer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking customer changes.

  ## Examples

      iex> change_customer(customer)
      %Ecto.Changeset{source: %Customer{}}

  """
  def change_customer(%Customer{} = customer) do
    Customer.changeset(customer, %{})
  end
end
