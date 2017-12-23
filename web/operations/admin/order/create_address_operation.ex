require IEx
defmodule AdminManager.Order.CreateAddressOperation do
  alias AdminManager.Repo
  alias AdminManager.Address

  def call(params) do
    changeset = Address.changeset(%Address{}, params)
    Repo.insert(changeset)
  end
end
