defmodule AdminManager.Admin.AdminController do
  use AdminManager.Web, :controller

  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Admin" when action in [:index, :show, :new, :edit]
  plug :set_page_function_name

  def index(conn, _params) do
    render conn, "index.html", title: conn.assigns.title, page_function_name: conn.assigns.page_function_name
  end
end
