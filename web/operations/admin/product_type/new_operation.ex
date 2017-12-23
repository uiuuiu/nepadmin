defmodule AdminManager.Admin.ProductType.NewOperation do
  alias AdminManager.ProductType

  def call do
    ProductType.changeset(%ProductType{})
  end
end
