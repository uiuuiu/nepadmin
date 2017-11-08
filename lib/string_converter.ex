defmodule StringConverter do
  @moduledoc false
  # 20170101 => 01/01/2017
  def stringdate_to_date(day, format) do
    Timex.format! Timex.parse!(day, format, :strftime), "%d/%m/%Y", :strftime
  end

  def stringtoday_to_date(day) do
    Timex.format! day, "%d/%m/%Y", :strftime
  end

  def stringdate_to_db_data(day, format) do
    Timex.format! Timex.parse!(day, format, :strftime), "%Y%m%d", :strftime
  end
end