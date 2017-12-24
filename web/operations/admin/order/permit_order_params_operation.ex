require IEx
defmodule AdminManager.Order.PermitOrderParamsOperation do
  def call(new_order_params, full_name_customer, customer, address) do
    new_order_params |> Map.merge(%{ "code" => "#{Date.utc_today}-#{full_name_customer}-#{elem(customer, 1).id}",
                                               "customer_name" => full_name_customer,
                                               "customer_id" => elem(customer, 1).id,
                                               "address_id" => elem(address, 1).id})
  end
end
