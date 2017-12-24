defmodule AdminManager.Admin.Producer.EditOperation do
  alias AdminManager.Repo
  alias AdminManager.Producer

  def call(id) do
    producer = Repo.get(Producer, id)
    {Producer.changeset(%Producer{}, %{name: producer.name}), producer}
  end
end
