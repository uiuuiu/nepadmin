require IEx
defmodule AdminManager.Admin.ProductDetailController do
  use AdminManager.Web, :controller
  alias AdminManager.Product
  alias AdminManager.Producer
  alias AdminManager.ProductDetailVersion
  alias AdminManager.ProductType

  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Product Detail"
  plug :set_page_function_name

  def index(conn, _params) do
    conn = assign(conn, :page_function_name, "List")
    products = Product
      |> Repo.all
    render(conn, "index.html", products: products, title: conn.assigns.title, page_function_name: conn.assigns.page_function_name)
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{})
    render(conn, "new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
  end

  def create(conn, %{"product_detail_version" => product_detail_version_params}) do
    start_day = StringConverter.stringdate_to_db_data(product_detail_version_params["effect_start_day"], "%d/%m/%Y")
    end_day = StringConverter.stringdate_to_db_data(product_detail_version_params["effect_end_day"], "%d/%m/%Y")
    product_detail_version_params = Map.put(product_detail_version_params, "effect_start_day", start_day)
    product_detail_version_params = Map.put(product_detail_version_params, "effect_end_day", end_day)
    profit = String.to_integer(product_detail_version_params["price"]) - String.to_integer(product_detail_version_params["initial_price"])
    product_detail_version_params = Map.put(product_detail_version_params, "profit", profit)
    # IEx.pry
    changeset = ProductDetailVersion.new_changset(%ProductDetailVersion{}, product_detail_version_params)
    case Repo.insert(changeset) do
      {:ok, _product} ->
        conn
          |> put_flash(:info, "Product abc created a version successfully.")
            |> redirect(to: admin_product_detail_path(conn, :index))
      {:error, changeset} ->
        errors = Enum.map(changeset.errors, fn {field_error, error_message} ->
          render_detail(error_message)
        end)
        conn
          |> put_flash(:error, errors)
            |> redirect(to: admin_product_detail_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}) do
    product = Repo.get(Product, id)
    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Repo.get(Product, id)
    product = Repo.preload(product, [:product_detail_versions, latest_product_detail_version: Product.latest_product_detail_version])
    if product.latest_product_detail_version do
      latest_product_detail_version = Repo.preload(product.latest_product_detail_version, [:product, :producer, :product_type])
      changeset = ProductDetailVersion.changeset(product.latest_product_detail_version)
    else
      latest_product_detail_version = %ProductDetailVersion{product_id: product.id}
        |> Repo.preload([:product])
      changeset = ProductDetailVersion.changeset(%ProductDetailVersion{}, %{product_id: product.id})
    end
    producers = Repo.all(Producer)
    product_types = Repo.all(ProductType)
    # changeset = ProductDetailVersion.changeset(%ProductDetailVersion{}, %{product_id: product.id})
    render(conn, "edit.html", changeset: changeset,
      product: product,
      latest_product_detail_version: latest_product_detail_version,
      producers: producers,
      product_types: product_types)
  end

  def update(conn, %{"id" => id, "product_detail_version" => product_detail_version_params}) do
    product_detail_version = Repo.get(ProductDetailVersion, id)
    start_day = StringConverter.stringdate_to_db_data(product_detail_version_params["effect_start_day"], "%d/%m/%Y")
    end_day = StringConverter.stringdate_to_db_data(product_detail_version_params["effect_end_day"], "%d/%m/%Y")
    product_detail_version_params = Map.put(product_detail_version_params, "effect_start_day", start_day)
    product_detail_version_params = Map.put(product_detail_version_params, "effect_end_day", end_day)
    profit = String.to_integer(product_detail_version_params["price"]) - String.to_integer(product_detail_version_params["initial_price"])
    product_detail_version_params = Map.put(product_detail_version_params, "profit", profit)
    changeset = ProductDetailVersion.changeset(product_detail_version, product_detail_version_params)
    case Repo.update(changeset) do
      {:ok, _product_detail_version} ->
        conn
          |> put_flash(:info, "Product abc updated a version successfully.")
            |> redirect(to: admin_product_detail_path(conn, :index))
      {:error, changeset} ->
        page_function_name = "Edit"
        render(conn, "edit.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
    end
  end

  defp render_detail({message, values}) do
    Enum.reduce values, message, fn {k, v}, acc ->
      String.replace(acc, "%{#{k}}", to_string(v))
    end
  end

  defp render_detail(message) do
    message
  end
end
