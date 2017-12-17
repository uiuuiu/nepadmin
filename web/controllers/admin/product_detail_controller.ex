require IEx
defmodule AdminManager.Admin.ProductDetailController do
  use AdminManager.Web, :controller
  alias AdminManager.Product
  alias AdminManager.Producer
  alias AdminManager.ProductDetailVersion
  alias AdminManager.ProductType
  #<= alias OPERATIONS
  alias AdminManager.Admin.ProductDetail.UpdateProductDetailOperation
  alias AdminManager.Admin.ProductDetail.InitEditDataOperation
  alias AdminManager.ErrorRenderOperation

  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Product Detail"
  plug :set_page_function_name

  def index(conn, _params) do
    products = Product
      |> Repo.all
    conn
      |> assign(:page_function_name, "List")
        |> render("index.html", products: products, title: conn.assigns.title, page_function_name: conn.assigns.page_function_name)
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{})
    render(conn, "new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
  end

  def create(conn, %{"product_detail_version" => object_params}) do
    start_day = StringConverter.stringdate_to_db_data(object_params["effect_start_day"], "%d/%m/%Y")
    end_day = StringConverter.stringdate_to_db_data(object_params["effect_end_day"], "%d/%m/%Y")
    object_params = Map.put(object_params, "effect_start_day", start_day)
    object_params = Map.put(object_params, "effect_end_day", end_day)
    if String.strip(object_params["price"]) != "" && String.strip(object_params["initial_price"]) != "" do
      profit = String.to_integer(object_params["price"]) - String.to_integer(object_params["initial_price"])
    end
    object_params = Map.put(object_params, "profit", profit)
    # IEx.pry
    changeset = ProductDetailVersion.new_changset(%ProductDetailVersion{}, object_params)
    case Repo.insert(changeset) do
      {:ok, _product} ->
        conn
          |> put_flash(:info, "Product abc created a version successfully.")
            |> redirect(to: admin_product_detail_path(conn, :index))
      {:error, changeset} ->
        errors = ErrorRenderOperation.render_multi_errors(changeset)
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
    {product, latest_product_detail_version, changeset, producers, product_types} = InitEditDataOperation.init_edit_data(id)
    # changeset = ProductDetailVersion.changeset(%ProductDetailVersion{}, %{product_id: product.id})
    render(conn, "edit.html", changeset: changeset,
      product: product,
      latest_product_detail_version: latest_product_detail_version,
      producers: producers,
      product_types: product_types)
  end

  def update(conn, %{"id" => id, "product_detail_version" => object_params}) do
    operaton_status = UpdateProductDetailOperation.start(conn, id, object_params)
    case operaton_status do
      {:ok, _product_detail_version} ->
        conn
          |> put_flash(:info, "Product abc updated a version successfully.")
            |> redirect(to: admin_product_detail_path(conn, :index))

      {:error, changeset} ->
        {product, latest_product_detail_version, _, producers, product_types} = InitEditDataOperation.init_edit_data(id, object_params)
        errors = ErrorRenderOperation.render_multi_errors(changeset)
        conn
          |> assign(:page_function_name, "Edit")
            |> put_flash(:error, errors)
              |> render("edit.html", changeset: changeset,
                  product: product,
                  latest_product_detail_version: latest_product_detail_version,
                  producers: producers,
                  product_types: product_types)
    end
  end
end
