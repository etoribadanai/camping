defmodule CampingWeb.Router do
  use CampingWeb, :router
  alias Camping.Guardian

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/", CampingWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", CampingWeb do
    pipe_through [:api]

    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
    resources("/products", ProductController)
  end

  scope "/api/v1", CampingWeb do
    pipe_through [:api, :jwt_authenticated]

    resources("/orders", OrderController)
    get "/my_user", UserController, :show
  end
end
