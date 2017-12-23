defmodule AdminManager.Order.LoadOrderOperation do
  alias AdminManager.Repo

  def call(params) do
    order = Repo.get(Order, params["id"])
    order = Repo.preload(order, [:address, :customer])
  end
end
