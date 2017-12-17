require IEx
defmodule AdminManager.Admin.ProductDetail.UpdateProductDetailOperation do
  import AdminManager.Router.Helpers
  alias AdminManager.Repo
  alias AdminManager.ProductDetailVersion

  def start(conn, id, object_params) do
    unit = init(id)
    #=> unit = if init/.. return a value
    #=> units = if init/.. reurn a List

    #<= CONVERT
    start_day = StringConverter.stringdate_to_db_data(object_params["effect_start_day"], "%d/%m/%Y")
    end_day = StringConverter.stringdate_to_db_data(object_params["effect_end_day"], "%d/%m/%Y")
    object_params = Map.put(object_params, "effect_start_day", start_day)
    object_params = Map.put(object_params, "effect_end_day", end_day)
    profit = StringConverter.to_integer(object_params["price"]) - StringConverter.to_integer(object_params["initial_price"])
    object_params = Map.put(object_params, "profit", profit)

    #<= VALIDATE AT PARAMS LAYER
    validate_params(object_params)

    #<= MODEL UPDATE OPERATION
    changeset = ProductDetailVersion.edit_changset(unit, object_params)
    IEx.pry
    Repo.update(changeset)
  end

  defp init(id) do
    Repo.get(ProductDetailVersion, id)
  end

  defp validate_params(object_params) do

  end
end
