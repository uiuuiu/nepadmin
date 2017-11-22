defmodule AdminManager.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :code, :string
      add :customer_name, :string
      add :customer_mobile_phone, :string
      add :customer_phone, :string
      add :goods_address, :text
      add :expected_delivery_date, :string
      add :expected_delivery_time, :string
      add :expected_receive_date, :string
      add :expected_receive_time, :string
      add :real_delivery_date, :string
      add :real_delivery_time, :string
      add :total, :decimal

      add :customer_id, references(:customers, on_delete: :nothing)
      add :address_id, references(:addresses, on_delete: :nothing)

      timestamps()
    end
  end
end
