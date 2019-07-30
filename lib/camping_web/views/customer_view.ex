defmodule CampingWeb.CustomerView do
  use CampingWeb, :view
  alias CampingWeb.CustomerView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, CustomerView, "customer.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{id: customer.id, email: customer.email, password_hash: customer.password_hash}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
