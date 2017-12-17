require IEx
defmodule AdminManager.Admin.ProductDetail.InitEditDataOperation do
  alias AdminManager.Repo
  alias AdminManager.Product
  alias AdminManager.Producer
  alias AdminManager.ProductType
  alias AdminManager.ProductDetail
  alias AdminManager.ProductDetailVersion

  def init_edit_data(id, object_params \\ nil) do
    if object_params do
      product = Repo.get(Product, object_params["product_id"])
      product = Repo.preload(product, [:product_detail_versions, latest_product_detail_version: Product.latest_product_detail_version])
      latest_product_detail_version = Repo.get(ProductDetailVersion, id)
        |> Repo.preload([:product, :producer, :product_type])
      IEx.pry
      changeset = ProductDetailVersion.changeset(latest_product_detail_version)
    else
      product = Repo.get(Product, id)
      product = Repo.preload(product, [:product_detail_versions, latest_product_detail_version: Product.latest_product_detail_version])
      if product.latest_product_detail_version do
        latest_product_detail_version = Repo.preload(product.latest_product_detail_version, [:product, :producer, :product_type])
        changeset = ProductDetailVersion.changeset(product.latest_product_detail_version)
      else
        latest_product_detail_version = %ProductDetailVersion{product_id: product.id}
          |> Repo.preload([:product])
        changeset = ProductDetailVersion.changeset(%ProductDetailVersion{}, %{product_id: product.id})
      end
    end
    producers = Repo.all(Producer)
    product_types = Repo.all(ProductType)
    {product, latest_product_detail_version, changeset, producers, product_types}
  end
end
