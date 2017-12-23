defmodule AdminManager.Admin.Producer.CreateOperation do
  alias AdminManager.Repo
  alias AdminManager.Producer

  def call(producer_params) do
    changeset = Producer.changeset(%Producer{}, producer_params)
    Repo.insert(changeset)
  end
end
