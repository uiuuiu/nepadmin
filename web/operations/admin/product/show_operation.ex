defmodule AdminManager.Admin.Product.ShowOperation do
  alias AdminManager.Repo
  alias AdminManager.Product

  def call(id) do
    Repo.get(Product, id)
  end
end
