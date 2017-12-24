require IEx
defmodule AdminManager.Order.CreateCustomerOperation do
  alias AdminManager.Repo
  alias AdminManager.Customer

  def call(params) do
    changeset = Customer.changeset(%Customer{}, params)
    Repo.insert(changeset)
  end
end
