defmodule AdminManager.ShipCostTest do
  use AdminManager.ModelCase

  alias AdminManager.ShipCost

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ShipCost.changeset(%ShipCost{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ShipCost.changeset(%ShipCost{}, @invalid_attrs)
    refute changeset.valid?
  end
end
