defmodule AdminManager.ProductDetailVersionTest do
  use AdminManager.ModelCase

  alias AdminManager.ProductDetailVersion

  @valid_attrs %{amount: 42, initial_price: "120.5", price: "120.5", profit: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ProductDetailVersion.changeset(%ProductDetailVersion{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ProductDetailVersion.changeset(%ProductDetailVersion{}, @invalid_attrs)
    refute changeset.valid?
  end
end
