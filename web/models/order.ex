defmodule AdminManager.Order do
  use AdminManager.Web, :model

  schema "orders" do
    belongs_to :customer, AdminManager.Customer
    belongs_to :address, AdminManager.Address

    field :code, :string
    field :customer_name, :string
    field :customer_mobile_phone, :string
    field :customer_phone, :string
    field :goods_address, :string
    field :expected_delivery_date, :string
    field :expected_delivery_time, :string
    field :expected_receive_date, :string
    field :expected_receive_time, :string
    field :real_delivery_date, :string
    field :real_delivery_time, :string
    field :total, :decimal

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:customer_name, :customer_mobile_phone, :customer_phone, :goods_address, :expected_delivery_date, :expected_delivery_time, :expected_receive_date, :expected_receive_time, :real_delivery_date, :real_delivery_time, :total])
    |> validate_required([:customer_name, :customer_mobile_phone, :customer_phone, :goods_address, :expected_delivery_date, :expected_delivery_time, :expected_receive_date, :expected_receive_time, :real_delivery_date, :real_delivery_time, :total])
  end
end
