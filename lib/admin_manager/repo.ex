defmodule AdminManager.Repo do
  use Ecto.Repo, otp_app: :admin_manager
  @behaviour AdminManager.SoftDelete

  import Ecto.Query, only: [where: 2]
  import Ecto.DateTime, only: [utc: 0]
  import Ecto.Changeset, only: [change: 2]
  import Ecto.Queryable, only: [to_query: 1]

  alias AdminManager.Repo

  require Ecto.Query

  # def all(queryable, opts \\ [])
  def all(queryable, opts) when length(opts) == 0 do
    queryable =  exclude_thrash(queryable)
    Repo.all(queryable)
  end
  def all(queryable, opts) when length(opts) > 0 do
    case with_thrash_option?(opts) do
      true ->
        queryable = exclude_thrash(queryable, false)
        opts = Keyword.drop(opts, [:with_thrash])
        Repo.all(queryable, opts)
      _ ->
        opts = Keyword.drop(opts, [:with_thrash])
        all(queryable, opts)
    end
  end

  # def get(queryable, id, opts \\ [])
  def get(queryable, id, opts) when length(opts) == 0 do
    queryable = exclude_thrash(queryable)
    Repo.get(queryable, id, opts)
  end
  def get(queryable, id, opts) when length(opts) > 0 do
    case with_thrash_option?(opts) do
      true ->
        queryable = exclude_thrash(queryable, false)
        opts = Keyword.drop(opts, [:with_thrash])
        Repo.get(queryable, id, opts)
      _ ->
        opts = Keyword.drop(opts, [:with_thrash])
        get(queryable, id, opts)
    end
  end

  # def delete(struct, opts \\ [])
  def delete(struct, opts) when length(opts) == 0 do
    changeset = change(struct, deleted_at: utc())
    Repo.update(changeset)
  end
  def delete(struct, opts) when length(opts) > 0 do
    case with_force_option?(opts) do
      true ->
        opts = Keyword.drop(opts, [:force])
        Repo.delete(struct, opts)
      _ -> delete(struct)
    end
  end

  # def delete_all(queryable, opts \\ [])
  def delete_all(queryable, opts) when length(opts) == 0 do
    Repo.update_all(queryable, set: [deleted_at: utc()])
  end
  def delete_all(queryable, opts) when length(opts) > 0 do
    case with_force_option?(opts) do
      true ->
        opts = Keyword.drop(opts, [:force])
        Repo.delete_all(queryable, opts)
      _ ->
        delete_all(queryable)
    end
  end

  def restore(queryable, id) do
    changeset = change(get!(queryable, id), deleted_at: nil)
    update(changeset)
  end

  defp schema_fields(%{from: {_source, schema}}) when schema != nil, do: schema.__schema__(:fields)

  defp field_exists?(queryable, column) do
    query = to_query(queryable)
    fields = schema_fields(query)

    Enum.member?(fields, column)
  end

  defp exclude_thrash(queryable, exclude \\ true) do
    case field_exists?(queryable, :deleted_at) do
      false -> queryable
      true ->
        cond do
          exclude -> where(queryable, fragment("deleted_at IS NULL"))
          !exclude-> queryable
        end
    end
  end

  defp with_thrash_option?(opts), do: Keyword.get(opts, :with_thrash)

  defp with_force_option?(opts), do: Keyword.get(opts, :force)

  defdelegate config(), to: AdminManager.Repo

  # defdelegate get!(queryable, id, opts \\ []), to: AdminManager.Repo

  # defdelegate get_by(queryable, clauses, opts \\ []), to: AdminManager.Repo

  # defdelegate get_by!(queryable, clauses, opts \\ []), to: AdminManager.Repo

  # defdelegate in_transaction?(), to: AdminManager.Repo

  # defdelegate insert(struct, opts \\ []), to: AdminManager.Repo

  # defdelegate insert!(struct, opts \\ []), to: AdminManager.Repo

  # defdelegate insert_all(schema_or_source, entries, opts \\ []), to: AdminManager.Repo

  # defdelegate insert_or_update(changeset, opts \\ []), to: AdminManager.Repo

  # defdelegate insert_or_update!(changeset, opts \\ []), to: AdminManager.Repo

  # defdelegate one(queryable, opts \\ []), to: AdminManager.Repo

  # defdelegate one!(queryable, opts \\ []), to: AdminManager.Repo

  # defdelegate preload(struct_or_structs, preloads, opts \\ []), to: AdminManager.Repo

  # defdelegate rollback(value), to: AdminManager.Repo

  # defdelegate start_link(opts \\ []), to: AdminManager.Repo

  # defdelegate stop(pid, timeout \\ 5000), to: AdminManager.Repo

  # defdelegate transaction(fun_or_multi, opts \\ []), to: AdminManager.Repo

  # defdelegate update(struct, opts \\ []), to: AdminManager.Repo

  # defdelegate update!(struct, opts \\ []), to: AdminManager.Repo

  # defdelegate update_all(queryable, updates, opts \\ []), to: AdminManager.Repo

  # defdelegate delete!(struct, opts \\ []), to: AdminManager.Repo
end
