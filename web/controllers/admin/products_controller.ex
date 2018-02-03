require IEx
defmodule AdminManager.Admin.ProductsController do
  use AdminManager.Web, :controller
  alias AdminManager.ErrorRenderOperation
  alias AdminManager.Admin.Product.IndexOperation
  alias AdminManager.Admin.Product.NewOperation
  alias AdminManager.Admin.Product.CreateOperation
  alias AdminManager.Admin.Product.EditOperation
  alias AdminManager.Admin.Product.UpdateOperation
  alias AdminManager.Admin.Product.ShowOperation
  alias AdminManager.Admin.Product.DeleteOperation

  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Product"
  plug :set_page_function_name

  def index(conn, _params) do
    products = IndexOperation.call
    render(conn, "index.html", products: products, title: conn.assigns.title, page_function_name: "List")
  end

  def new(conn, _params) do
    changeset = NewOperation.call
    render(conn, "new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
  end

  def create(conn, %{"product" => product_params}) do
    create_product = CreateOperation.call(product_params)
    case create_product do
      {:ok, _product} ->
        conn
          |> put_flash(:info, "Product created successfully.")
            |> redirect(to: admin_products_path(conn, :index))
      {:error, changeset} ->
        errors = ErrorRenderOperation.render_multi_errors(changeset)
        conn
          |> put_flash(:error, errors)
            |> redirect(to: admin_products_path(conn, :new))
    end
  end

  def show(conn, %{"id" => id}) do
    product = ShowOperation.call(id)
    render(conn, "show.html", product: product, page_function_name: conn.assigns.page_function_name)
  end

  def edit(conn, %{"id" => id}) do
    {changeset, product} = EditOperation.call(id)
    render(conn, "edit.html", changeset: changeset, product: product, page_function_name: conn.assigns.page_function_name)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    update_product = UpdateOperation.call(id, product_params)
    case update_product do
      {:ok, _product} ->
        conn
          |> put_flash(:info, "Product Updated successfully.")
            |> redirect(to: admin_products_path(conn, :edit, id))
      {:error, changeset} ->
        errors = ErrorRenderOperation.render_multi_errors(changeset)
        conn
          |> put_flash(:error, errors)
            |> redirect(to: admin_products_path(conn, :new))
    end
  end

  def delete(conn, %{"id" => id}) do
    delete_product = DeleteOperation.call(id)
    case delete_product do
      {:ok, _product} ->
        conn = put_flash(conn, :info, "Product deleted successfully.")
      {:error, changeset} ->
        conn = put_flash(conn, :error, "Something went wrong!")
    end
    redirect(conn, to: admin_products_path(conn, :index))
  end
end
