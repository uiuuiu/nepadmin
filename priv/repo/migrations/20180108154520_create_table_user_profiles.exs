defmodule AdminManager.Repo.Migrations.CreateTableUserProfiles do
  use Ecto.Migration

  def change do
    create table(:user_profiles) do
      add :code, :string
      add :joined_date, :utc_datetime
      add :first_name, :string
      add :middle_name, :string
      add :last_name, :string
      add :gender, :integer
      add :phone, :integer
      add :home_town, :string
      add :current_address, :string
      # chung minh nhan dan
      add :number_identity, :string

      timestamps()
    end
  end
end
