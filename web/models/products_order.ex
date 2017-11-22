defmodule AdminManager.ProductsOrder do
  use AdminManager.Web, :model

  schema "products_orders" do
    belongs_to :order, AdminManager.Order
    belongs_to :product, AdminManager.Product

    field :amount, :integer
    field :collection_money, :decimal

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount, :collection_money])
    |> validate_required([:amount, :collection_money])
  end
end
