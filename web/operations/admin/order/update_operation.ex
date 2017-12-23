defmodule AdminManager.Admin.UpdateOperation do
  alias AdminManager.Repo
  alias AdminManager.Order
  alias AdminManager.Customer
  alias AdminManager.Address
  alias AdminManager.Order.Helper.ConvertDateTimeOperation

  def call(id, order_params) do
    order = Repo.get(Order, id)
    customer = Repo.preload(order, :customer).customer
    AdminManager.Admin.UpdateOperation.update_customer(order, order_params, customer)
    AdminManager.Admin.UpdateOperation.update_address(order, order_params)
    AdminManager.Admin.UpdateOperation.update_order(order_params, customer, order)
  end

  def update_order(order_params, customer, order) do
    new_order_params   = ConvertDateTimeOperation.call(order_params)
    full_name_customer = "#{order_params["first_name"]} #{order_params["middle_name"]} #{order_params["last_name"]}"
    order_permitted    = new_order_params |> Map.merge(%{ "code" => "#{Date.utc_today}-#{full_name_customer}-#{customer.id}",
                                                          "customer_name" => full_name_customer})
    changeset = Order.changeset(order, order_permitted)
    Repo.update(changeset)
  end

  def update_customer(order, order_params, customer) do
    changeset = Customer.changeset(customer, order_params)
    Repo.update(changeset)
  end

  def update_address(order, order_params) do
    address = Repo.preload(order, :address).address
    changeset = Address.changeset(address, order_params)
    Repo.update(changeset)
  end
end
