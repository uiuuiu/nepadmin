defmodule AdminManager.Repo.Migrations.CreateCalendar do
  use Ecto.Migration

  def change do
    create table(:calendars) do
      add :day_of_month, :string, size: 2
      add :month, :string, size: 2
      add :year, :string, size: 4
      add :date, :string, size: 8
      add :deleted_at, :utc_datetime, null: true

      timestamps()
    end
  end
end
