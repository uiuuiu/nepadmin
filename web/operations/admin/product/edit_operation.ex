defmodule AdminManager.Admin.Product.EditOperation do
  alias AdminManager.Repo
  alias AdminManager.Product

  def call(id) do
    product = Repo.get(Product, id)
    {Product.changeset(%Product{}, %{name: product.name}), product}
  end
end
