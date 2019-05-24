defmodule AdminManager.Router do
  use AdminManager.Web, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {AdminManager.LayoutView, :admin_app}
    plug Coherence.Authentication.Session, protected: true
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end


  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AdminManager do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/admin", AdminManager.Admin, as: :admin do
    pipe_through :protected
    get "/", AdminController, :index
    resources "/products", ProductsController
    resources "/producers", ProducersController
    resources "/product_types", ProductTypesController
    resources "/product_detail", ProductDetailController
    scope "/statistics", Statistics do
      resources "/day_statistic", DayStatisticController
      resources "/week_statistic", WeekStatisticController
    end
    resources "/orders", OrdersController
  end

  # Other scopes may use custom stacks.
  # scope "/api", AdminManager do
  #   pipe_through :api
  # end
end
