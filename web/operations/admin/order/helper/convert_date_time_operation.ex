require IEx
defmodule AdminManager.Order.Helper.ConvertDateTimeOperation do
  def call(order_params) do
    %{ order_params|
       "expected_delivery_date" => order_params["expected_delivery_date"] |> Map.values |> Enum.join("-"),
       "expected_receive_date"  => order_params["expected_receive_date"]  |> Map.values |> Enum.join("-"),
       "real_delivery_date"     => order_params["real_delivery_date"]     |> Map.values |> Enum.join("-"),
       "expected_delivery_time" => order_params["expected_delivery_time"] |> Map.values |> Enum.join(":"),
       "expected_receive_time"  => order_params["expected_receive_time"]  |> Map.values |> Enum.join(":"),
       "real_delivery_time"     => order_params["real_delivery_time"]     |> Map.values |> Enum.join(":"),
    }
  end
end
