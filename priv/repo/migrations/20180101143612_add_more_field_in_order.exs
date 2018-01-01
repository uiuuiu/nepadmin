defmodule AdminManager.Repo.Migrations.AddMoreFieldInOrder do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :partner_id, :integer
      add :status, :integer
      add :status_text, :string
      add :message, :string
      add :facebook_number, :string
    end
  end
end
