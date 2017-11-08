defmodule AdminManager.ProductTypeTest do
  use AdminManager.ModelCase

  alias AdminManager.ProductType

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ProductType.changeset(%ProductType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ProductType.changeset(%ProductType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
