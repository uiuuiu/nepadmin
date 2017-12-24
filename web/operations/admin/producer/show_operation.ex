defmodule AdminManager.Admin.Producer.ShowOperation do
  alias AdminManager.Repo
  alias AdminManager.Producer

  def call(id) do
    Repo.get(Producer, id)
  end
end
