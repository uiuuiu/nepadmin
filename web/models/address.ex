defmodule AdminManager.Address do
  use AdminManager.Web, :model

  schema "addresses" do
    has_many :orders, AdminManager.Order, on_delete: :delete_all

    field :address_info, :string
    field :city_name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:address_info, :city_name])
    |> validate_required([:address_info, :city_name])
  end
end
