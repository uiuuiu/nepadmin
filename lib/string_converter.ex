require IEx
defmodule StringConverter do
  @moduledoc false
  #<= DATETIME
  # 20170101 => 01/01/2017
  def stringdate_to_date(day, format) do
    Timex.format! Timex.parse!(day, format, :strftime), "%d/%m/%Y", :strftime
  end

  def stringtoday_to_date(day) do
    Timex.format! day, "%d/%m/%Y", :strftime
  end

  def stringtoday_to_datetime(day) do
    Timex.format! day, "%d/%m/%Y %H:%M:%S", :strftime
  end

  def stringdate_to_db_data(day, format) do
    try do
      Timex.format! Timex.parse!(day, format, :strftime), "%Y%m%d", :strftime
    rescue
      e in Timex.Parse.ParseError -> ""
    end
  end

  #<= INTEGER

  def to_integer(string) do
    result = Integer.parse(string)
    case result do
      {number, _} -> number
      :error -> 0
    end
  end
end
