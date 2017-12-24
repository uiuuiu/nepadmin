defmodule AdminManager.Admin.Producer.NewOperation do
  alias AdminManager.Producer

  def call do
    Producer.changeset(%Producer{})
  end
end
