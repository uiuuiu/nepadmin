defmodule AdminManager.Admin.Producer.IndexOperation do
  alias AdminManager.Repo
  alias AdminManager.Producer

  def call do
    producers = Producer |> Repo.all
  end
end
