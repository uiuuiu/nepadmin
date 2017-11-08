defmodule AdminManager.ProductDayStatistic do
  @moduledoc false
  use AdminManager.Web, :model

  schema "product_day_statistics" do
    field :amount, :integer
    field :profit, :decimal

    belongs_to :product, AdminManager.Product
    belongs_to :product_detail_version, AdminManager.ProductDetailVersion
    belongs_to :calendar, AdminManager.Calendar
    belongs_to :sale, AdminManager.Sale

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount, :profit, :product_id, :product_detail_version_id, :calendar_id, :sale_id])
  end

  def product_day_statistic_by_day(calendar_id) do
    from c in AdminManager.ProductDayStatistic,
      where: c.calendar_id == ^calendar_id
  end

  def product_day_statistic_by_week(calendar_ids) do
    from c in AdminManager.ProductDayStatistic,
      where: c.calendar_id in ^calendar_ids
  end
end
