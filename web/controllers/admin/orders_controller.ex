require IEx
defmodule AdminManager.Admin.OrdersController do
  use AdminManager.Web, :controller
  alias AdminManager.Order
  alias AdminManager.Customer
  alias AdminManager.Address

  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Order" when action in [:index, :show, :new, :edit]
  plug :set_page_function_name when action in [:index, :new]

  def index(conn, _params) do
    orders = Repo.all(Order)
    render(conn, "index.html", orders: orders, title: conn.assigns.title)
  end

  def new(conn, _params) do
    changeset = Order.changeset(%Order{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"order" => order_params}) do
    customer = AdminManager.Admin.OrdersController.create_customer(order_params)
    address  = AdminManager.Admin.OrdersController.create_address(order_params)
    AdminManager.Admin.OrdersController.create_order(order_params, customer, address)
    conn |> redirect(to: admin_orders_path(conn, :index))
  end

  def create_order(order_params, customer, address) do
    new_order_params   = AdminManager.Admin.OrdersController.convert_date_time_order_params(order_params)
    full_name_customer = "#{elem(customer, 1).first_name} #{elem(customer, 1).middle_name} #{elem(customer, 1).last_name}"
    order_permitted    = new_order_params |> Map.merge(%{ "code" => "#{Date.utc_today}-#{full_name_customer}-#{elem(customer, 1).id}",
                                                          "customer_name" => full_name_customer,
                                                          "customer_id" => elem(customer, 1).id,
                                                          "address_id" => elem(address, 1).id})
    changeset          = Order.changeset(%Order{}, order_permitted)
    Repo.insert(changeset)
  end

  def create_customer(order_params) do
    changeset = Customer.changeset(%Customer{}, order_params)
    Repo.insert(changeset)
  end

  def create_address(order_params) do
    changeset = Address.changeset(%Address{}, order_params)
    Repo.insert(changeset)
  end

  def convert_date_time_order_params(order_params) do
    %{ order_params|
       "expected_delivery_date" => order_params["expected_delivery_date"] |> Map.values |> Enum.join("-"),
       "expected_receive_date"  => order_params["expected_receive_date"]  |> Map.values |> Enum.join("-"),
       "real_delivery_date"     => order_params["real_delivery_date"]     |> Map.values |> Enum.join("-"),
       "expected_delivery_time" => order_params["expected_delivery_time"] |> Map.values |> Enum.join(":"),
       "expected_receive_time"  => order_params["expected_receive_time"]  |> Map.values |> Enum.join(":"),
       "real_delivery_time"     => order_params["real_delivery_time"]     |> Map.values |> Enum.join(":"),
    }
  end

  def show(conn, params) do
    order = Repo.get(Order, params["id"])
    order = Repo.preload(order, [:address, :customer])
    render(conn, "show.html", order: order, page_function_name: order.code)
  end

  def delete(conn, params) do
    order = Repo.get(Order, params["id"])
    case Repo.delete(order) do
      {:ok, _order} ->
        conn = put_flash(conn, :info, "Order deleted successfully.")
      {:error, changeset} ->
        conn = put_flash(conn, :error, "Something went wrong!")
    end
    redirect(conn, to: admin_orders_path(conn, :index))
  end

  def edit(conn, params) do
    order = Repo.get(Order, params["id"])
    order = Repo.preload(order, [:address, :customer])
    changeset = Order.changeset(%Order{})
    render(conn, "edit.html", changeset: changeset, order: order, page_function_name: order.code)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Repo.get(Order, id)
    customer = Repo.preload(order, :customer).customer
    new_order_params   = AdminManager.Admin.OrdersController.convert_date_time_order_params(order_params)
    full_name_customer = "#{order_params["first_name"]} #{order_params["middle_name"]} #{order_params["last_name"]}"
    order_permitted    = new_order_params |> Map.merge(%{ "code" => "#{Date.utc_today}-#{full_name_customer}-#{customer.id}",
                                                          "customer_name" => full_name_customer})
    changeset = Order.changeset(order, order_permitted)
    AdminManager.Admin.OrdersController.update_customer(order, order_params)
    AdminManager.Admin.OrdersController.update_address(order, order_params)
    case Repo.update(changeset) do
      {:ok, _order} ->
        conn = put_flash(conn, :info, "Order Updated successfully.")
      {:error, changeset} ->
        conn = put_flash(conn, :error, "Something went wrong!")
    end
    redirect(conn, to: admin_orders_path(conn, :index))
  end

  def update_customer(order, order_params) do
    customer = Repo.preload(order, :customer).customer
    changeset = Customer.changeset(customer, order_params)
    Repo.update(changeset)
  end

  def update_address(order, order_params) do
    address = Repo.preload(order, :address).address
    changeset = Address.changeset(address, order_params)
    Repo.update(changeset)
  end
end
