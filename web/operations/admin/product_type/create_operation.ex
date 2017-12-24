defmodule AdminManager.Admin.ProductType.CreateOperation do
  alias AdminManager.Repo
  alias AdminManager.ProductType

  def call(product_type_params) do
    changeset = ProductType.changeset(%ProductType{}, product_type_params)
    Repo.insert(changeset)
  end
end
