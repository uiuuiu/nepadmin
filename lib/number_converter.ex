defmodule NumberConverter do
  @moduledoc false
  def to_vnd_currency(number) do
    if number do
      Number.Currency.number_to_currency(number, [unit: "VND", format: "%n %u", precision: 0])
    else
      "0 VND"
    end
  end
end