require IEx
defmodule AdminManager.Admin.ProductTypesController do
  use AdminManager.Web, :controller
  alias AdminManager.ProductType

  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Product Type" when action in [:index, :show, :new, :edit]
  plug :set_page_function_name

  def index(conn, _params) do
    conn = assign(conn, :page_function_name, "List")
    product_types = ProductType
      |> Repo.all
    render(conn, "index.html", product_types: product_types, title: conn.assigns.title, page_function_name: conn.assigns.page_function_name)
  end

  def new(conn, _params) do
    changeset = ProductType.changeset(%ProductType{})
    render(conn, "new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
  end

  def create(conn, %{"product_type" => product_type_params}) do
    changeset = ProductType.changeset(%ProductType{}, product_type_params)
    case Repo.insert(changeset) do
      {:ok, _product} ->
        conn
          |> put_flash(:info, "Product Type created successfully.")
            |> redirect(to: admin_product_types_path(conn, :index))
      {:error, changeset} ->
        conn
          |> assign(:page_function_name, "New")
            |> render("new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
    end
  end

  def show(conn, %{"id" => id}) do
    product_type = Repo.get(ProductType, id)
    render(conn, "show.html", product_type: product_type, page_function_name: conn.assigns.page_function_name)
  end

  def edit(conn, %{"id" => id}) do
    product_type = Repo.get(ProductType, id)
    changeset = ProductType.changeset(%ProductType{}, %{name: product_type.name})
    render(conn, "edit.html", changeset: changeset, product_type: product_type, page_function_name: conn.assigns.page_function_name)
  end

  def update(conn, %{"id" => id, "product_type" => product_type_params}) do
    product_type = Repo.get(ProductType, id)
    changeset = ProductType.changeset(product_type, product_type_params)
    case Repo.update(changeset) do
      {:ok, _product_type} ->
        conn
          |> put_flash(:info, "Product type Updated successfully.")
            |> redirect(to: admin_product_types_path(conn, :edit, id))
      {:error, changeset} ->
        conn
          |> assign(:page_function_name, "Edit")
            |> put_flash(:error, "Something went wrong!")
              |> render("edit.html", changeset: changeset, product_type: product_type, page_function_name: conn.assigns.page_function_name)
    end
  end

  def delete(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    product_type = Repo.get(ProductType, id)
    case Repo.delete(product_type) do
      {:ok, _product_type} ->
        conn = put_flash(conn, :info, "Product Type deleted successfully.")
      {:error, changeset} ->
        conn = put_flash(conn, :error, "Something went wrong!")
    end
    redirect(conn, to: admin_producers_path(conn, :index))
  end
end
