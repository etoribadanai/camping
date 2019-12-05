defmodule Camping.Factory do
  use ExMachina.Ecto, repo: Camping.Repo
  alias Camping.Repo

  def customer_factory do
    %Camping.Accounts.Schemas.Customer{
      name: "Mr. Test",
      cpf: "#{Enum.random(0..99_999_999_999)}",
      phone_area: "11",
      phone_number: "123455678",
      birth_date: "1996-05-16"
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
