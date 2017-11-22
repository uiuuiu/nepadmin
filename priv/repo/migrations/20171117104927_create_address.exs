defmodule AdminManager.Repo.Migrations.CreateAddress do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :address_info, :string
      add :city_name, :string

      timestamps()
    end
  end
end
