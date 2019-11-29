defmodule UserTest do
  use ExUnit.Case, async: true
  doctest CampingWeb.UserController
  alias Camping.Factory
  alias Camping.Accounts

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Camping.Repo)
  end

   describe "User" do
    test "created when passed all fields and creates successfully" do
      customer = Factory.insert(:customer)
      {:ok, user} = Accounts.create_user(customer.id, %{"email" => customer.email, "password" => "123456"})

      assert user != nil
      assert user.email == customer.email
    end

    @tag :mustexec
    test "Do not create when passed wrong fields" do
      customer = Factory.insert(:customer)
      {:error, msg} = Accounts.create_user(customer.id, %{"email" => customer.email})

      assert msg.errors == [password: {"can't be blank", [validation: :required]}]
    end

    test "sign in when passed all fields correctly" do
      customer = Factory.insert(:customer)
      {:ok, user} = Accounts.create_user(customer.id, %{"email" => customer.email, "password" => "123456"})

      {:ok, token, _name} = Accounts.token_sign_in(user.email, user.password)

      assert token != nil
    end

    @tag :mustexec
    test "sign in when passed wrong password" do
      customer = Factory.insert(:customer)
      {:ok, user} = Accounts.create_user(customer.id, %{"email" => customer.email, "password" => "123456"})
      {:error, msg} = Accounts.token_sign_in(user.email, "xpto123")

      assert msg == :unauthorized
    end
  end
end
