defmodule AdminManager.Admin.Producer.DeleteOperation do
  alias AdminManager.Repo
  alias AdminManager.Producer

  def call(id) do
    producer = Repo.get(Producer, id)
    Repo.delete(producer)
  end
end
