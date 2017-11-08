defmodule AdminManager.ProducerTest do
  use AdminManager.ModelCase

  alias AdminManager.Producer

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Producer.changeset(%Producer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Producer.changeset(%Producer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
