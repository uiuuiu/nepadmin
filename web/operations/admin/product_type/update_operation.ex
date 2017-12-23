defmodule AdminManager.Admin.ProductType.UpdateOperation do
  alias AdminManager.Repo
  alias AdminManager.ProductType

  def call(id, product_type_params) do
    product_type = Repo.get(ProductType, id)
    changeset = ProductType.changeset(product_type, product_type_params)
    Repo.update(changeset)
  end
end
