defmodule AdminManager.Admin.AdminController do
  use AdminManager.Web, :controller
  plug :set_title
  plug :set_page_function_name

  def index(conn, _params) do
    render conn, "index.html", title: conn.assigns.title, page_function_name: conn.assigns.page_function_name
  end

  defp set_title(conn, _) do
    assign(conn, :title, "Welcome")
  end

  defp set_page_function_name(conn, _) do
    page_function_name = String.capitalize(Atom.to_string(action_name(conn)))
    assign(conn, :page_function_name, page_function_name)
  end
end
