defmodule SocialLoginTest do
  use ExUnit.Case, async: true
  doctest CampingWeb.SocialController
  alias Camping.Accounts.Social.HandleCreate

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Camping.Repo)
  end

   describe "Social Login" do
    test "created when passed all fields and creates successfully" do
      {:ok, social} =
        HandleCreate.create(
          %{
            "name" => "Etori",
            "image" => "xpto",
            "provider" => "Facebook",
            "token" => "31293819028301203",
            "uid" => "12313",
            "email" => "test@test.com.br"
          }
        )
      assert social != nil
    end

    @tag :mustexec
    test "Do not create when passed wrong fields" do
      {:error, msg} =
        HandleCreate.create(
          %{
            "name" => "Etori",
            "image" => "xpto",
            "provider" => "Facebook",
            "uid" => "12313",
            "email" => "test@test.com.br"
          }
        )

        assert msg.errors == [token: {"can't be blank", [validation: :required]}]
    end
  end
end
