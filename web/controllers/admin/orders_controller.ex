require IEx
defmodule AdminManager.Admin.OrdersController do
  use AdminManager.Web, :controller
  alias AdminManager.Order
  alias AdminManager.Order.Helper.ConvertDateTimeOperation
  alias AdminManager.Order.CreateCustomerOperation
  alias AdminManager.Order.CreateAddressOperation
  alias AdminManager.Order.PermitOrderParamsOperation
  alias AdminManager.Order.LoadOrderOperation
  alias AdminManager.Order.ShowOperation
  alias AdminManager.Admin.UpdateOperation

  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Order"
  plug :set_page_function_name when action in [:index, :new]

  def index(conn, _params) do
    orders = AdminManager.Order.IndexOperation.call
    conn |> render("index.html", orders: orders, title: conn.assigns.title)
  end

  def new(conn, _params) do
    changeset = AdminManager.Order.NewOperation.call
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"order" => order_params}) do
    Repo.transaction(fn ->
      customer           = CreateCustomerOperation.call(order_params)
      address            = CreateAddressOperation.call(order_params)
      new_order_params   = ConvertDateTimeOperation.call(order_params)
      full_name_customer = "#{elem(customer, 1).first_name} #{elem(customer, 1).middle_name} #{elem(customer, 1).last_name}"
      order_permitted    = PermitOrderParamsOperation.call(new_order_params, full_name_customer, customer, address)
      changeset          = Order.changeset(%Order{}, order_permitted)
      Repo.insert(changeset)
      conn |> redirect(to: admin_orders_path(conn, :index))
    end)
  end

  def show(conn, params) do
    order = ShowOperation.call(params)
    render(conn, "show.html", order: order, page_function_name: order.code)
  end

  def delete(conn, params) do
    order = AdminManager.Order.DeleteOperation.call(conn, params)
    case order do
      {:ok, _order} ->
        conn = put_flash(conn, :info, "Order deleted successfully.")
      {:error, changeset} ->
        conn = put_flash(conn, :error, "Something went wrong!")
    end
    redirect(conn, to: admin_orders_path(conn, :index))
  end

  def edit(conn, params) do
    {order, changeset} = AdminManager.Order.EditOperation.call(params)
    render(conn, "edit.html", changeset: changeset, order: order, page_function_name: order.code)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    Repo.transaction(fn ->
      update_order = UpdateOperation.call(id, order_params)
      case update_order do
        {:ok, _order} ->
          conn = put_flash(conn, :info, "Order Updated successfully.")
        {:error, changeset} ->
          conn = put_flash(conn, :error, "Something went wrong!")
      end
      redirect(conn, to: admin_orders_path(conn, :index))
    end)
  end
end
