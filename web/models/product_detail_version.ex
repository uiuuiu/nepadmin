require IEx
defmodule AdminManager.ProductDetailVersion do
  @moduledoc false
  use AdminManager.Web, :model
  alias AdminManager.Repo
  alias AdminManager.Product
  alias AdminManager.ProductDetailVersion
  # defstruct changeset: %ProductDetailVersion{}

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
  end

  def new_changset(struct, params \\ %{}) do
    struct
      |> cast(params, [:price, :amount, :initial_price, :profit, :product_id, :producer_id, :product_type_id, :effect_start_day, :effect_end_day])
      |> validate_required([:price, :amount, :initial_price, :profit, :product_id, :effect_start_day, :effect_end_day])
      |> validate_number(:initial_price, less_than: 10, message: "Initial price must be greater than 10")
      |> validate_effect_day
  end

  def edit_changset(struct, params \\ %{}) do
    struct
      |> cast(params, [:price, :amount, :initial_price, :profit, :product_id, :producer_id, :product_type_id, :effect_start_day, :effect_end_day])
      |> validate_required([:price, :amount, :initial_price, :profit, :product_id, :effect_start_day, :effect_end_day])
      |> validate_number(:initial_price, less_than: 10, message: "Initial price must be greater than 10")
      |> validate_effect_day
  end

  # def validate_effect_day(changeset, options \\ []), do: changeset

  def validate_effect_day(changeset, options \\ []) do

    case Enum.any?(changeset.errors) do
      true ->
        changeset
      false ->
        duplicate_range_version = Repo.one(from x in ProductDetailVersion,
                                  where: x.product_id == ^changeset.changes[:product_id],
                                  where: x.effect_start_day >= ^changeset.changes[:effect_start_day],
                                  where: x.effect_end_day <= ^changeset.changes[:effect_end_day],
                                  limit: 1)
        validate_change(changeset, :effect_start_day, fn _, effect_start_day ->
          case duplicate_range_version == nil do
            true -> []
            false -> [effect_start_day: options[:message] || "New effect start is duplicated"]
          end
        end)
    end
  end
end
