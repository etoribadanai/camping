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
  Gets a single customer.

  Raises `Ecto.NoResultsError` if the customer does not exist.

  ## Examples

      iex> get_customer_by(cpf: "3702568974")
      %Customer{}

      iex> get_customer_by(cpf: "3702568974")
      nil

  """
  def get_customer_by(fields), do: Repo.get_by(Customer, fields)

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
  def get_user_by(fields), do: Repo.get_by(User, fields)
  def get_social_by(fields), do: Repo.get_by(Social, fields)

  def token_sign_in(value, password) do
    cond do
      is_email?(value) == true ->
        sign_in_with_email(value, password)

      is_cpf?(value) == true ->
        sign_in_with_cpf(value, password)

      true ->
        {:error, "Value is not valid to sign_in"}
    end
  end

  defp sign_in_with_email(value, password) do
    with {:ok, user} <- email_password_auth(value, password),
         {:ok, token, _claims} = Guardian.encode_and_sign(user),
         {:ok, _} <- store_token(user, token) do
      {:ok, token, get_customer(user.customer_id).name}
    else
      _ -> {:error, :unauthorized}
    end
  end

  defp sign_in_with_cpf(value, password) do
    with %Customer{} = customer <- get_customer_by(cpf: value),
         %User{} = user <- get_user_by(customer_id: customer.id),
         {:ok, user} <- email_password_auth(user.email, password),
         {:ok, token, _claims} = Guardian.encode_and_sign(user),
         {:ok, _} <- store_token(user, token) do
      {:ok, token, get_customer(user.customer_id).name}
    else
      _ -> {:error, :unauthorized}
    end
  end

  defp is_email?(value), do: String.contains?(value, "@")
  defp is_cpf?(value), do: Regex.match?(~r/\d/, value)

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
  def create_social_login(attrs \\ %{}) do
    # attrs = Map.put(attrs, "customer_id", customer_id)
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
  Updates a User password.

  ## Examples

      iex> update_password(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_password(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_password(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a Social Login.

  ## Examples

      iex> update_social_login(social, %{field: new_value})
      {:ok, %Social{}}

      iex> update_social_login(social, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_social_login(%Social{} = social, attrs) do
    social
    |> Social.changeset(attrs)
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
