defmodule AdminManager.Router do
  use AdminManager.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug NavigationHistory.Tracker
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug AdminManager.Plugs.Admin.AdminPagePlug
    plug :put_layout, {AdminManager.LayoutView, :admin_app}
  end

  scope "/", AdminManager do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/admin", AdminManager.Admin, as: :admin do
    pipe_through [:browser, :admin]
    get "/", AdminController, :index
    resources "/products", ProductsController
    resources "/producers", ProducersController
    resources "/product_types", ProductTypesController
    resources "/product_detail", ProductDetailController
    scope "/statistics", Statistics do
      resources "/day_statistic", DayStatisticController
      resources "/week_statistic", WeekStatisticController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", AdminManager do
  #   pipe_through :api
  # end
end
