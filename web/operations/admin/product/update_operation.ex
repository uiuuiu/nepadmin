defmodule AdminManager.Admin.Product.UpdateOperation do
  alias AdminManager.Repo
  alias AdminManager.Product

  def call(id, product_params) do
    product = Repo.get(Product, id)
    changeset = Product.changeset(product, product_params)
    Repo.update(changeset)
  end
end
