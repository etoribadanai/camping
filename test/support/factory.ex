defmodule Camping.Factory do
  use ExMachina.Ecto, repo: Camping.Repo
  alias Camping.Repo

  def customer_factory do
    %Camping.Accounts.Schemas.Customer{
      name: "Mr. Test",
      email: "test@test.com.br"
    }
  end
end
