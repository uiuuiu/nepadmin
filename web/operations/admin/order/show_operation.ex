require IEx
defmodule AdminManager.Order.ShowOperation do
  alias AdminManager.Repo
  alias AdminManager.Order

  def call(params) do
    order = Repo.get(Order, params["id"])
    Repo.preload(order, [:address, :customer])
  end
end
