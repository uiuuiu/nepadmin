defmodule AdminManager.Order.IndexOperation do
  alias AdminManager.Repo
  alias AdminManager.Order

  def call do
    Order |> Repo.all
  end
end
