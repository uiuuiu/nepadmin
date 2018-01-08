defmodule AdminManager.Repo.Migrations.CreateTableRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :level, :integer
      timestamps()
    end
  end
end
