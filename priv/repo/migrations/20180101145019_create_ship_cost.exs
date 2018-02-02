defmodule AdminManager.Repo.Migrations.CreateShipCost do
  use Ecto.Migration

  def change do
    create table(:ship_costs) do
      add :ship_money, :decimal
      add :insurance, :decimal
      add :value, :string
      add :weight, :decimal
      add :pick_money, :decimal
      add :status, :integer
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps()
    end
  end
end
