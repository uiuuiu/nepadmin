defmodule AdminManager.Calendar do
  @moduledoc false
  use AdminManager.Web, :model

  schema "calendars" do
    field :day_of_month, :string
    field :month, :string
    field :year, :string
    field :date, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:day_of_month, :month, :year, :date])
    |> validate_required([:day_of_month, :month, :year, :date])
  end
end
