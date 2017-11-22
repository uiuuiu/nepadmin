defmodule AdminManager.ProductsOrderTest do
  use AdminManager.ModelCase

  alias AdminManager.ProductsOrder

  @valid_attrs %{amount: 42, collection_money: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ProductsOrder.changeset(%ProductsOrder{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ProductsOrder.changeset(%ProductsOrder{}, @invalid_attrs)
    refute changeset.valid?
  end
end
