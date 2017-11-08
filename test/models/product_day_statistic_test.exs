defmodule AdminManager.ProductDayStatisticTest do
  use AdminManager.ModelCase

  alias AdminManager.ProductDayStatistic

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ProductDayStatistic.changeset(%ProductDayStatistic{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ProductDayStatistic.changeset(%ProductDayStatistic{}, @invalid_attrs)
    refute changeset.valid?
  end
end
