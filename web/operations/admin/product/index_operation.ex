defmodule AdminManager.Admin.Product.IndexOperation do
  alias AdminManager.Repo
  alias AdminManager.Product

  def call do
    product = Product |> Repo.all
  end
end
