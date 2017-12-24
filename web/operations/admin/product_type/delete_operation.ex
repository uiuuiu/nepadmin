defmodule AdminManager.Admin.ProductType.DeleteOperation do
  alias AdminManager.Repo
  alias AdminManager.ProductType

  def call(id) do
    product_type = Repo.get(ProductType, id)
    Repo.delete(product_type)
  end
end
