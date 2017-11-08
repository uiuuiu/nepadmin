defmodule AdminManager.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      # add :producer_id, references(:producers, on_delete: :nothing)
      add :deleted_at, :utc_datetime, null: true

      timestamps()
    end
  end
end
