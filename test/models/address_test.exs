defmodule AdminManager.AddressTest do
  use AdminManager.ModelCase

  alias AdminManager.Address

  @valid_attrs %{address_info: "some address_info", city_name: "some city_name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Address.changeset(%Address{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Address.changeset(%Address{}, @invalid_attrs)
    refute changeset.valid?
  end
end
