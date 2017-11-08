defmodule AdminManager.Repo.Migrations.CreateProductType do
  use Ecto.Migration

  def change do
    create table(:product_types) do
      add :name, :string
      add :deleted_at, :utc_datetime, null: true

      timestamps()
    end
  end
end
