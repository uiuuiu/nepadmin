defmodule AdminManager.CalendarTest do
  use AdminManager.ModelCase

  alias AdminManager.Calendar

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Calendar.changeset(%Calendar{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Calendar.changeset(%Calendar{}, @invalid_attrs)
    refute changeset.valid?
  end
end
