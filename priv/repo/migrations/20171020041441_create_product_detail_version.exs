defmodule AdminManager.Repo.Migrations.CreateProductDetailVersion do
  use Ecto.Migration

  def change do
    create table(:product_detail_versions) do
      add :price, :decimal
      add :amount, :integer
      add :initial_price, :decimal
      add :profit, :decimal
      add :effect_start_day, :string, size: 8
      add :effect_end_day, :string, size: 8
      add :deleted_at, :utc_datetime, null: true

      add :product_id, references(:products, on_delete: :nothing)
      add :producer_id, references(:producers, on_delete: :nothing)
      add :product_type_id, references(:product_types, on_delete: :nothing)

      timestamps()
    end
  end
end
