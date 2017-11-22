defmodule AdminManager.OrderTest do
  use AdminManager.ModelCase

  alias AdminManager.Order

  @valid_attrs %{customer_mobile_phone: "some customer_mobile_phone", customer_name: "some customer_name", customer_phone: "some customer_phone", expected_delivery_date: "some expected_delivery_date", expected_delivery_time: "some expected_delivery_time", expected_receive_date: "some expected_receive_date", expected_receive_time: "some expected_receive_time", goods_address: "some goods_address", real_delivery_date: "some real_delivery_date", real_delivery_time: "some real_delivery_time", total: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Order.changeset(%Order{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Order.changeset(%Order{}, @invalid_attrs)
    refute changeset.valid?
  end
end
