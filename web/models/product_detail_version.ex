defmodule AdminManager.ProductDetailVersion do
  @moduledoc false
  use AdminManager.Web, :model

  schema "product_detail_versions" do
    field :price, :decimal
    field :amount, :integer
    field :initial_price, :decimal
    field :profit, :decimal
    field :effect_start_day, :string
    field :effect_end_day, :string

    # field :product_id, :integer
    # field :producer_id, :integer
    # field :product_type_id, :integer

    timestamps()

    belongs_to :product, AdminManager.Product
    belongs_to :producer, AdminManager.Producer
    belongs_to :product_type, AdminManager.ProductType
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:price, :amount, :initial_price, :profit, :product_id, :producer_id, :product_type_id, :effect_start_day, :effect_end_day])
    |> validate_required([:price, :amount, :initial_price, :profit, :product_id, :effect_start_day, :effect_end_day])
  end
end
