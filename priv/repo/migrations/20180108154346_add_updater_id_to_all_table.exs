defmodule AdminManager.Repo.Migrations.AddUpdaterIdToAllTable do
  use Ecto.Migration

  def change do
    alter table(:addresses) do
      add :updater_id, :integer
    end

    alter table(:calendars) do
      add :updater_id, :integer
    end

    alter table(:customers) do
      add :updater_id, :integer
    end

    alter table(:orders) do
      add :updater_id, :integer
    end

    alter table(:producers) do
      add :updater_id, :integer
    end

    alter table(:product_day_statistics) do
      add :updater_id, :integer
    end

    alter table(:product_detail_versions) do
      add :updater_id, :integer
    end

    alter table(:product_types) do
      add :updater_id, :integer
    end

    alter table(:products) do
      add :updater_id, :integer
    end

    alter table(:products_orders) do
      add :updater_id, :integer
    end

    alter table(:sales) do
      add :updater_id, :integer
    end

    alter table(:users) do
      add :updater_id, :integer
    end
  end
end
