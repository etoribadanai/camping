defmodule Camping.Factory do
  use ExMachina.Ecto, repo: Camping.Repo
  alias Camping.Repo

  def customer_factory do
    %Camping.Accounts.Schemas.Customer{
      name: "Mr. Test",
      email: "test@test.com.br"
    }
  end

  def product_factory do
    %Camping.Products.Schemas.Product{
      code: sequence(:code, &"1#{&1}"),
      description: "ProdTest",
      price: :rand.uniform(1000) / 1
    }
  end
end
