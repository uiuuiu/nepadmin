require IEx
defmodule AdminManager.Admin.Statistics.WeekStatisticController do
  use AdminManager.Web, :controller
  alias AdminManager.Calendar
  alias AdminManager.Product
  alias AdminManager.Sale
  alias AdminManager.ProductDayStatistic

  import AdminManager.Plugs.Admin.PageNavigatorPlug
  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Week statistic" when action in [:index, :show, :new, :edit]
  plug :set_page_function_name

  def index(conn, _params) do
    page_function_name = "List"
    changeset = Calendar.changeset(%Calendar{}, %{"date" => Date.to_iso8601(Date.utc_today, :basic)})
    week = Timex.week_of_month(Date.utc_today)
    render conn, "index.html", title: conn.assigns.title, changeset: changeset, page_function_name: page_function_name,
          week: week
  end

  def show(conn, %{"id" => id, "calendar" => calendar_params}) do
    date = "#{calendar_params["date"]["year"]}#{calendar_params["date"]["month"]}#{calendar_params["date"]["day"]}"
    year = String.to_integer(calendar_params["date"]["year"])
    month = String.to_integer(calendar_params["date"]["month"])
    week = String.to_integer(calendar_params["date"]["week"])
    days_in_month = Timex.days_in_month({year, month, 1})
    days_in_selected_week = for day <- 1..days_in_month do
      if Timex.week_of_month(year, month, day) == week do
        Timex.to_date({year, month, day})
      end
    end
    days_in_selected_week = Enum.filter(days_in_selected_week, & !is_nil(&1))
    days_in_selected_week = Enum.map(days_in_selected_week, fn(x) -> Date.to_iso8601(x, :basic) end)
    calendars = Repo.all(from c in Calendar, where: c.date in ^days_in_selected_week)
    calendar_ids = Enum.map(calendars, fn(x) -> x.id end)
    products = Repo.all(Product)
    products = Repo.preload(products, [:product_detail_versions, product_day_statistics: ProductDayStatistic.product_day_statistic_by_week(calendar_ids)])
    all_product_day_statistics = List.flatten(Enum.map(products, fn(x) -> x.product_day_statistics end))
    sales = Repo.all(Sale)
    changeset = Calendar.changeset(%Calendar{}, %{"date" => Date.to_iso8601(Date.utc_today, :basic)})
    render conn, "show.html", title: conn.assigns.title, changeset: changeset, page_function_name: conn.assigns.page_function_name,
           products: products, calendars: calendars, sales: sales, week: week, all_product_day_statistics: all_product_day_statistics
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
end
