defmodule CampingWeb.Router do
  use CampingWeb, :router
  alias Camping.Guardian

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(CORSPlug,
      origin: ["*"]
    )

    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:accepts, ["json"])
  end

  pipeline :jwt_authenticated do
    plug(Camping.Plugs.Context)
  end

  scope "/", CampingWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    options("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", CampingWeb do
    pipe_through([:api])

    scope "/user" do
      post("/create", UserController, :create)
      options("/create", UserController, :create)
      post("/sign_in", UserController, :sign_in)
      options("/sign_in", UserController, :sign_in)
      post("/reset_password", UserController, :reset_password)
      options("/reset_password", UserController, :reset_password)
    end

    scope "/social" do
      post("/create", SocialController, :create)
      options("/create", SocialController, :create)
      post("/sign_in", SocialController, :sign_in)
      options("/sign_in", SocialController, :sign_in)
    end

    scope "/tags" do
      resources("/", TagController)
      options("/", TagController, only: [:index, :show])
    end

    scope "/questions" do
      resources("/", QuestionController)
      options("/", QuestionController, only: [:index, :show])
    end
  end

  scope "/api/v1", CampingWeb do
    pipe_through([:api, :jwt_authenticated])

    scope "/products" do
      resources("/", ProductController)
      options("/", ProductController, only: [:index, :show])
      get("/trail/:id", ProductController, :products_to_trail)
      options("/trail/:id", ProductController, :products_to_trail)
    end

    scope "/orders" do
      resources("/", OrderController)
      options("/", OrderController, only: [:index, :create, :show])
    end

    scope "/customers" do
      resources("/", CustomerController)
      options("/", CustomerController, only: [:index, :show])
      post("/answer", CustomerAnswerController, :create_or_update)
      options("/answer", CustomerAnswerController, :create_or_update)
      get("/:id/answers", CustomerAnswerController, :list_answers)
      options("/:id/answers", CustomerAnswerController, :list_answers)
      get("/:id/answers/count", CustomerAnswerController, :customer_answered_count)
      options("/:id/answers/count", CustomerAnswerController, :customer_answered_count)
    end

    scope "/users" do
      resources("/", UserController)
      options("/", UserController, only: [:index, :show])
    end

    scope "/trails" do
      resources("/", TrailController)
      options("/", TrailController, only: [:index, :show])
    end

    scope "/campings" do
      resources("/", CampingController)
      options("/", CampingController, only: [:index, :show])
    end
  end
end
