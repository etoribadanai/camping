defmodule Camping.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Camping.Repo

  alias Camping.Accounts.Schemas.Customer
  alias Camping.Accounts.Schemas.User
  alias Camping.Accounts.Schemas.Social
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
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single customer.

  Raises `Ecto.NoResultsError` if the customer does not exist.

  ## Examples

      iex> get_customer(123)
      %Customer{}

      iex> get_customer(456)
      nil

  """
  def get_customer(id), do: Repo.get(Customer, id)

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the user does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

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
    with {:ok, user} <- email_password_auth(email, password),
         {:ok, token, _claims} = Guardian.encode_and_sign(user),
         {:ok, _} <- store_token(user, token) do
      {:ok, token}
    else
      _ -> {:error, :unauthorized}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email) do
      verify_password(password, user)
    end
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Login error."}

      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if checkpw(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end

  @doc """
  Returns an updated customer with new JWT stored in DB.

  ## Examples

      iex> store_token(user, token)
      {:ok, %User{}}

  """
  def store_token(%User{} = user, token) do
    user
    |> Ecto.Changeset.change(%{token: token})
    |> Repo.update()
  end

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
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(customer_id, attrs \\ %{}) do
    attrs = Map.put(attrs, "customer_id", customer_id)
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a social login.

  ## Examples

      iex> create_social_login(%{field: value})
      {:ok, %User{}}

      iex> create_social_login(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_social_login(customer_id, attrs \\ %{}) do
    attrs = Map.put(attrs, "customer_id", customer_id)
    %Social{}
    |> Social.changeset(attrs)
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
