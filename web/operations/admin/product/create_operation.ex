defmodule AdminManager.Admin.Product.CreateOperation do
  alias AdminManager.Repo
  alias AdminManager.Product

  def call(product_params) do
    changeset = Product.changeset(%Product{}, product_params)
    Repo.insert(changeset)
  end
end
