require IEx
defmodule AdminManager.Admin.ProductTypesController do
  use AdminManager.Web, :controller
  alias AdminManager.ErrorRenderOperation
  alias AdminManager.Admin.ProductType.IndexOperation
  alias AdminManager.Admin.ProductType.NewOperation
  alias AdminManager.Admin.ProductType.CreateOperation
  alias AdminManager.Admin.ProductType.EditOperation
  alias AdminManager.Admin.ProductType.UpdateOperation
  alias AdminManager.Admin.ProductType.ShowOperation
  alias AdminManager.Admin.ProductType.DeleteOperation

  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Product Type"
  plug :set_page_function_name

  def index(conn, _params) do
    product_types = IndexOperation.call
    render(conn, "index.html", product_types: product_types, title: conn.assigns.title, page_function_name: "List")
  end

  def new(conn, _params) do
    changeset = NewOperation.call
    render(conn, "new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
  end

  def create(conn, %{"product_type" => product_type_params}) do
    create_product_type = CreateOperation.call(product_type_params)
    case create_product_type do
      {:ok, _product} ->
        conn
          |> put_flash(:info, "Product Type created successfully.")
            |> redirect(to: admin_product_types_path(conn, :index))
      {:error, changeset} ->
        errors = ErrorRenderOperation.render_multi_errors(changeset)
        conn
          |> put_flash(:error, errors)
            |> redirect(to: admin_product_types_path(conn, :new))
    end
  end

  def show(conn, %{"id" => id}) do
    product_type = ShowOperation.call(id)
    render(conn, "show.html", product_type: product_type, page_function_name: conn.assigns.page_function_name)
  end

  def edit(conn, %{"id" => id}) do
    {changeset, product_type} = EditOperation.call(id)
    render(conn, "edit.html", changeset: changeset, product_type: product_type, page_function_name: conn.assigns.page_function_name)
  end

  def update(conn, %{"id" => id, "product_type" => product_type_params}) do
    update_product_type = UpdateOperation.call(id, product_type_params)
    case update_product_type do
      {:ok, _product_type} ->
        conn
          |> put_flash(:info, "Product type Updated successfully.")
            |> redirect(to: admin_product_types_path(conn, :index))
      {:error, changeset} ->
        errors = ErrorRenderOperation.render_multi_errors(changeset)
        conn
          |> put_flash(:error, errors)
            |> redirect(to: admin_product_types_path(conn, :edit, id))
    end
  end

  def delete(conn, %{"id" => id}) do
    delete_product_type = DeleteOperation.call(id)
    case delete_product_type do
      {:ok, _product_type} ->
        conn = put_flash(conn, :info, "Product Type deleted successfully.")
      {:error, changeset} ->
        conn = put_flash(conn, :error, "Something went wrong!")
    end
    redirect(conn, to: admin_producers_path(conn, :index))
  end
end
