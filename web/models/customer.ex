defmodule AdminManager.Customer do
  use AdminManager.Web, :model

  schema "customers" do
    has_many :orders, AdminManager.Order, on_delete: :delete_all

    field :first_name, :string
    field :last_name, :string
    field :middle_name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :middle_name])
    |> validate_required([:first_name, :last_name, :middle_name])
  end
end
