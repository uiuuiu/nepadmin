defmodule AdminManager.SaleTest do
  use AdminManager.ModelCase

  alias AdminManager.Sale

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sale.changeset(%Sale{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sale.changeset(%Sale{}, @invalid_attrs)
    refute changeset.valid?
  end
end
