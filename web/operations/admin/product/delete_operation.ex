defmodule AdminManager.Admin.Product.DeleteOperation do
  alias AdminManager.Repo
  alias AdminManager.Product

  def call(id) do
    product = Repo.get(Product, id)
    Repo.delete(product)
  end
end
