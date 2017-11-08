require IEx
defmodule AdminManager.Admin.ProductTypesController do
  use AdminManager.Web, :controller
  alias AdminManager.ProductType
  plug :set_title
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
        conn = assign(conn, :page_function_name, "New")
        render(conn, "new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
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
    Repo.get(ProductType, id)
    |> ProductType.changeset(product_type_params)
    |> Repo.update
    redirect(conn, to: admin_product_types_path(conn, :edit, id))
  end

  defp set_title(conn, _) do
    assign(conn, :title, "Product Type")
  end

  defp set_page_function_name(conn, _) do
    page_function_name = String.capitalize(Atom.to_string(action_name(conn)))
    assign(conn, :page_function_name, page_function_name)
  end
end
