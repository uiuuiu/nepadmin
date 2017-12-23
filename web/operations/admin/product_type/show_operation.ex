defmodule AdminManager.Admin.ProductType.ShowOperation do
  alias AdminManager.Repo
  alias AdminManager.ProductType

  def call(id) do
    Repo.get(ProductType, id)
  end
end
