defmodule AdminManager.Product do
  @moduledoc false
  use AdminManager.Web, :model
  import Ecto.Query

  schema "products" do
    field :name, :string

    has_one :latest_product_detail_version, AdminManager.ProductDetailVersion
    has_many :product_detail_versions, AdminManager.ProductDetailVersion, on_delete: :delete_all
    has_one :product_day_statistic, AdminManager.ProductDayStatistic
    has_many :product_day_statistics, AdminManager.ProductDayStatistic, on_delete: :delete_all
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  def new_changeset(struct, params \\ %{}) do
    cast(struct, params, [:name])
  end

  def latest_product_detail_version do
    from c in AdminManager.ProductDetailVersion,
      order_by: [desc: c.id], limit: 1
  end
end
