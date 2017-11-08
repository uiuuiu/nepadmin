defmodule AdminManager.Repo.Migrations.CreateSale do
  use Ecto.Migration

  def change do
    create table(:sales) do
      add :name, :string
      add :deleted_at, :utc_datetime, null: true

      timestamps()
    end
  end
end
