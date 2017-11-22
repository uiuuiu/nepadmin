require IEx
defmodule AdminManager.Admin.OrdersController do
  use AdminManager.Web, :controller
  alias AdminManager.Order

  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Order" when action in [:index, :show, :new, :edit]
  plug :set_page_function_name

  def index(conn, _params) do
    orders = Repo.all(Order)
    render(conn, "index.html", orders: orders, title: conn.assigns.title)
  end
end
