defmodule Mango.Web.Router do
  use Mango.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Mango.Web.Plugs.LoadCustomer
    plug Mango.Web.Plugs.FetchCart
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Mango.Web do
    pipe_through :browser

    get "/", PageController, :index
    get "/categories/:name", CategoryController, :show

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete

    post "/cart", CartController, :add
  end
end
