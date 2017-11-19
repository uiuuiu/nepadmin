defmodule AdminManager.CustomerTest do
  use AdminManager.ModelCase

  alias AdminManager.Customer

  @valid_attrs %{first_name: "some first_name", last_name: "some last_name", middle_name: "some middle_name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Customer.changeset(%Customer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Customer.changeset(%Customer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
