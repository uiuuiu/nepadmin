defmodule AdminManager.Admin.ProductType.IndexOperation do
  alias AdminManager.Repo
  alias AdminManager.ProductType

  def call do
    ProductType |> Repo.all
  end
end
