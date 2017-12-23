defmodule AdminManager.Admin.Producer.UpdateOperation do
  alias AdminManager.Repo
  alias AdminManager.Producer

  def call(id, producer_params) do
    producer = Repo.get(Producer, id)
    changeset = Producer.changeset(producer, producer_params)
    Repo.update(changeset)
  end
end
