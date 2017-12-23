defmodule AdminManager.Order.EditOperation do
  alias AdminManager.Repo
  alias AdminManager.Order

  def call(params) do
    order = Repo.get(Order, params["id"])
    order = Repo.preload(order, [:address, :customer])
    changeset = Order.changeset(%Order{})
    {order, changeset}
  end
end
