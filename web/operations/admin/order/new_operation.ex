defmodule AdminManager.Order.NewOperation do
  alias AdminManager.Order

  def call do
    Order.changeset(%Order{})
  end
end
