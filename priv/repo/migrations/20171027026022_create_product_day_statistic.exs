defmodule AdminManager.Repo.Migrations.CreateProductDayStatistic do
  use Ecto.Migration

  def change do
    create table(:product_day_statistics) do
      add :amount, :integer
      add :profit, :decimal
      add :deleted_at, :utc_datetime, null: true

      add :product_id, references(:products, on_delete: :nothing), null: true
      add :product_detail_version_id, references(:product_detail_versions, on_delete: :nothing), null: true
      add :calendar_id, references(:calendars, on_delete: :nothing), null: true
      add :sale_id, references(:sales, on_delete: :nothing), null: true
      timestamps()
    end
  end
end
