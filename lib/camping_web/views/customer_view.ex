defmodule CampingWeb.CustomerView do
  use CampingWeb, :view
  alias CampingWeb.CustomerView

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{
      id: customer.id,
      email: customer.email,
      name: customer.name,
      birth_date: customer.birth_date,
      cpf: customer.cpf,
      phone_area: customer.phone_area,
      phone_number: customer.phone_number
    }
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
