defmodule AdminManager.Repo.Migrations.CreateProductsOrder do
  use Ecto.Migration

  def change do
    create table(:products_orders) do
      add :amount, :integer
      add :collection_money, :decimal

      add :order_id, references(:orders, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end
  end
end
