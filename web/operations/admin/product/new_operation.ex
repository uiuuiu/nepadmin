defmodule AdminManager.Admin.Product.NewOperation do
  alias AdminManager.Product

  def call do
    Product.changeset(%Product{})
  end
end
