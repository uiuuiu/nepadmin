defmodule AdminManager.SoftDelete do
  @moduledoc false
  @callback restore(Ecto.Queryable.t, integer) :: {:ok, Ecto.Schema.t} | {:error, Ecto.Changeset.t}
end