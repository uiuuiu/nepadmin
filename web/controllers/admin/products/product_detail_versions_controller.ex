require IEx
defmodule AdminManager.Admin.Products.ProductDetailVersionsController do
  use AdminManager.Web, :controller

  alias AdminManager.Repo
  alias AdminManager.Product
  alias AdminManager.Sale
  alias AdminManager.ProductDayStatistic
  alias AdminManager.Calendar

  import AdminManager.Plugs.Admin.PageInfoPlug

  def index(conn, params) do
    product = Repo.get(Product, params["product_id"])
    product = Repo.preload(product, [:product_detail_versions])
    sales   = Repo.all(Sale)
    calendar = Repo.get_by(Calendar, id: 168)
    product_day_statistic = ProductDayStatistic.changeset(%ProductDayStatistic{})
    conn
    |> render("detail_versions.js", sales: sales, product: product, product_day_statistic: product_day_statistic, calendar: calendar)
  end
end
