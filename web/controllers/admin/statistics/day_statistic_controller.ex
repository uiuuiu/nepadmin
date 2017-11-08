require IEx
defmodule AdminManager.Admin.Statistics.DayStatisticController do
  use AdminManager.Web, :controller
  alias AdminManager.Calendar
  alias AdminManager.Product
  alias AdminManager.Sale
  alias AdminManager.ProductDayStatistic
  plug :set_title
  plug :set_page_function_name

  def index(conn, _params) do
    page_function_name = "List"
    # IEx.pry
    changeset = Calendar.changeset(%Calendar{}, %{"date" => Date.to_iso8601(Date.utc_today, :basic)})
    render conn, "index.html", title: conn.assigns.title, changeset: changeset, page_function_name: page_function_name
  end

  def show(conn, %{"id" => id, "calendar" => calendar_params}) do
    date_month = String.pad_leading(calendar_params["date"]["month"], 2, "0")
    date_day = String.pad_leading(calendar_params["date"]["day"], 2, "0")
    date = "#{calendar_params["date"]["year"]}#{date_month}#{date_day}"
    calendar = Repo.get_by(Calendar, date: date)
    changeset = Calendar.changeset(calendar)
    products = Repo.all(Product)
    products = Repo.preload(products, [:product_detail_versions, product_day_statistic: ProductDayStatistic.product_day_statistic_by_day(calendar.id)])
    sales = Repo.all(Sale)
    render conn, "show.html", title: conn.assigns.title, changeset: changeset, page_function_name: conn.assigns.page_function_name,
           calendar: calendar, products: products, sales: sales
  end

  def create(conn, %{"calendar_id" => calendar_id, "product_day_statistics" => product_day_statistics_params}) do
    product_day_statistics_params = Enum.map(product_day_statistics_params, fn {key, value} -> value end)
    product_ids = Enum.map(product_day_statistics_params, fn(x) -> x["product_id"] end)
    products = Repo.all(from x in Product, where: x.id in ^product_ids)
    products = Repo.preload(products, [product_day_statistic: ProductDayStatistic.product_day_statistic_by_day(calendar_id)])
    for element_params <- product_day_statistics_params do
      product = Enum.find(products, fn(x) -> x.id == String.to_integer(element_params["product_id"]) end)

      if product do
        statistic = product.product_day_statistic
      end
      cond do
        statistic ->
          ProductDayStatistic.changeset(statistic, element_params)
          |> Repo.update
        product ->
          ProductDayStatistic.changeset(%ProductDayStatistic{}, element_params)
          |> Repo.insert
      end
    end
    conn
    |> put_flash(:info, "Producer created successfully.")
    |> redirect_back
  end

  defp set_title(conn, _) do
    assign(conn, :title, "Day Statistic")
  end

  defp set_page_function_name(conn, _) do
    page_function_name = String.capitalize(Atom.to_string(action_name(conn)))
    assign(conn, :page_function_name, page_function_name)
  end

  defp redirect_back(conn, opts \\ []) do
    Phoenix.Controller.redirect(conn, to: NavigationHistory.last_path(conn, opts))
  end
end
