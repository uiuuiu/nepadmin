defmodule AdminManager.Order.DeleteOperation do
  alias AdminManager.Repo
  alias AdminManager.Order

  def call(conn, params) do
    order = Repo.get(Order, params["id"])
    Repo.delete(order)
  end
end
