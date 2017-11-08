defmodule AdminManager.PageController do
  use AdminManager.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
