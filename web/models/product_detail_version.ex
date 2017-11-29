require IEx
defmodule AdminManager.ProductDetailVersion do
  @moduledoc false
  use AdminManager.Web, :model
  alias AdminManager.Repo
  alias AdminManager.Product
  alias AdminManager.ProductDetailVersion

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
    # |> validate_effect_day
  end

  def new_changset(struct, params \\ %{}) do
    struct
    |> cast(params, [:price, :amount, :initial_price, :profit, :product_id, :producer_id, :product_type_id, :effect_start_day, :effect_end_day])
    |> validate_required([:price, :amount, :initial_price, :profit, :product_id, :effect_start_day, :effect_end_day])
    |> validate_number(:initial_price, less_than: 10)
    |> validate_effect_day
  end

  def validate_effect_day(changeset, options \\ []) do
    latest_version = Repo.one(from x in ProductDetailVersion, where: x.product_id == ^changeset.changes[:product_id], order_by: [desc: x.effect_start_day], limit: 1)
    validate_change(changeset, :effect_start_day, fn _, effect_start_day ->
      IEx.pry
      case latest_version.effect_start_day < effect_start_day do
        true -> []
        false -> [effect_start_day: options[:message] || "new effect start day must be greater than #{latest_version.effect_start_day}"]
      end
    end)
    # validate_change(changeset, :effect_start_day, fn _, url ->
    #   case String.starts_with?(url, @our_url) do
    #     true -> []
    #     false -> [{field, options[:message] || "Unexpected URL"}]
    #   end
    # end)
  end
end
