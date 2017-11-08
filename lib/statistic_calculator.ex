require IEx
defmodule StatisticCalculator do
  @moduledoc false
  def calculate_total_amount(day_statistics) do
    day_statistics_by_calendar = Enum.filter(day_statistics, fn(x) -> !is_nil(x.amount) end)
    if day_statistics_by_calendar do
      total = Enum.sum(Enum.map(day_statistics_by_calendar, fn(x) -> x.amount end))
    else
      0
    end
  end

  def calculate_total_profit(day_statistics) do
    day_statistics_by_calendar = Enum.filter(day_statistics, fn(x) -> !is_nil(x.profit) end)
    if day_statistics_by_calendar do
      total = Enum.sum(Enum.map(day_statistics_by_calendar, fn(x) -> Decimal.to_float(x.profit) end))
      NumberConverter.to_vnd_currency(total)
    else
      NumberConverter.to_vnd_currency(0)
    end
  end

  def calculate_total_amount_by_day(day_statistics, calendar) do
    day_statistics_by_calendar = Enum.filter(day_statistics, fn(x) -> x.calendar_id == calendar.id && !is_nil(x.amount) end)
    if day_statistics_by_calendar do
      total = Enum.sum(Enum.map(day_statistics_by_calendar, fn(x) -> x.amount end))
    else
      0
    end
  end

  def calculate_total_profit_by_day(day_statistics, calendar) do
    day_statistics_by_calendar = Enum.filter(day_statistics, fn(x) -> x.calendar_id == calendar.id && !is_nil(x.profit) end)
    if day_statistics_by_calendar do
      total = Enum.sum(Enum.map(day_statistics_by_calendar, fn(x) -> Decimal.to_float(x.profit) end))
      NumberConverter.to_vnd_currency(total)
    else
      NumberConverter.to_vnd_currency(0)
    end
  end

  def calculate_total_amount_of_by_product(product) do
    if product.product_day_statistics do
      day_statistics_by_calendar = Enum.filter(product.product_day_statistics, fn(x) -> !is_nil(x.amount) end)
      total = Enum.sum(Enum.map(day_statistics_by_calendar, fn(x) -> x.amount end))
    else
      0
    end
  end

  def calculate_total_profit_of_by_product(product) do
    if product.product_day_statistics do
      day_statistics_by_calendar = Enum.filter(product.product_day_statistics, fn(x) -> !is_nil(x.profit) end)
      total = Enum.sum(Enum.map(day_statistics_by_calendar, fn(x) -> Decimal.to_float(x.profit) end))
      NumberConverter.to_vnd_currency(total)
    else
      NumberConverter.to_vnd_currency(0)
    end
  end
end