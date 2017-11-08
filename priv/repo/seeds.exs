# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AdminManager.Repo.insert!(%AdminManager.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.
require IEx
require Timex
require Date
alias AdminManager.Repo

calendar_range = Date.range(~D[2017-10-01], ~D[2020-12-31])
calendar_list = Enum.map(calendar_range, fn(x) -> Date.to_iso8601(x, :basic) end)
AdminManager.Repo.transaction( fn ->
  for calendar <- calendar_list do
    year = String.slice(calendar, 0..3)
    month = String.slice(calendar, 4..5)
    day_of_month = String.slice(calendar, 6..7)
    changeset = AdminManager.Calendar.changeset(%AdminManager.Calendar{}, %{"day_of_month" => day_of_month, "month" => month, "year" => year, "date" => calendar})
    Repo.insert!(changeset)
  end
end)

products = [
  %{name: "Sword"},
  %{name: "Blade"},
  %{name: "Spear"},
  %{name: "Bow"},
  %{name: "Crossbow"},
  %{name: "Knife"},
  %{name: "Wood Shield"},
  %{name: "Iron Shield"},
  %{name: "Iron Armor"},
  %{name: "Leather Gloves"},
  %{name: "Iron Helmet"}
]

products =
  products
    |> Enum.map(fn(row) ->
      row
        |> Map.put(:inserted_at, Timex.now)
        |> Map.put(:updated_at, Timex.now)
      end)
Repo.insert_all(AdminManager.Product, products)

producers = [
  %{name: "SAO"},
  %{name: "Log Horizon"},
  %{name: "Guilty Crown"},
  %{name: "Tokyo Ghoul"},
  %{name: "Overlord"},
  %{name: "Strike the Blood"}
]
producers =
  producers
    |> Enum.map(fn(row) ->
        row
          |> Map.put(:inserted_at, Timex.now)
          |> Map.put(:updated_at, Timex.now)
      end)
Repo.insert_all(AdminManager.Producer, producers)

product_types = [
  %{name: "Armor"},
  %{name: "Range Weapon"},
  %{name: "Meele Weapon"},
  %{name: "Armor"},
  %{name: "Gloves"},
  %{name: "Helmet"},
  %{name: "Shield"}
]
product_types =
  product_types
    |> Enum.map(fn(row) ->
        row
          |> Map.put(:inserted_at, Timex.now)
          |> Map.put(:updated_at, Timex.now)
      end)
Repo.insert_all(AdminManager.ProductType, product_types)

sales = [
  %{name: "Percent"},
  %{name: "Money"},
  %{name: "Coupon"}
]
sales =
  sales
    |> Enum.map(fn(row) ->
        row
          |> Map.put(:inserted_at, Timex.now)
          |> Map.put(:updated_at, Timex.now)
      end)
Repo.insert_all(AdminManager.Sale, sales)

products = Repo.all(AdminManager.Product)
producers = Repo.all(AdminManager.Producer)
product_types = Repo.all(AdminManager.ProductType)

product_detail_versions = for product <- products do
  %{price: 10000, amount: 10, initial_price: 5000, profit: 5000, effect_start_day: "20171001", effect_end_day: "20171231",
    product_id: product.id, product_type_id: Enum.random(product_types).id, producer_id: Enum.random(producers).id}
end
product_detail_versions =
  product_detail_versions
    |> Enum.map(fn(row) ->
        row
          |> Map.put(:inserted_at, Timex.now)
          |> Map.put(:updated_at, Timex.now)
      end)
Repo.insert_all(AdminManager.ProductDetailVersion, product_detail_versions)















