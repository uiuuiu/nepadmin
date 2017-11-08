defmodule AdminManager.Repo.Migrations.CreateProducer do
  use Ecto.Migration

  def change do
    create table(:producers) do
      add :name, :string
      add :deleted_at, :utc_datetime, null: true

      timestamps()
    end
  end
end
