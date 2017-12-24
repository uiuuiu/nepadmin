defmodule AdminManager.Admin.ProductType.EditOperation do
  alias AdminManager.Repo
  alias AdminManager.ProductType

  def call(id) do
    product_type = Repo.get(ProductType, id)
    {ProductType.changeset(%ProductType{}, %{name: product_type.name}), product_type}
  end
end
