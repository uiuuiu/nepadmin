require IEx
defmodule AdminManager.Admin.ProductsController do
  use AdminManager.Web, :controller
  alias AdminManager.Product
  plug :set_title
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

  def create(conn, %{"product" => product_params}) do
    changeset = Product.changeset(%Product{}, product_params)
    case Repo.insert(changeset) do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: admin_products_path(conn, :index))
      {:error, changeset} ->
        conn
        |> assign(:page_function_name, "New")
        |> render("new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Repo.get(Product, id)
    render(conn, "show.html", product: product, page_function_name: conn.assigns.page_function_name)
  end

  def edit(conn, %{"id" => id}) do
    product = Repo.get(Product, id)
    changeset = Product.changeset(%Product{}, %{name: product.name})
    render(conn, "edit.html", changeset: changeset, product: product, page_function_name: conn.assigns.page_function_name)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Repo.get(Product, id)
    changeset = Product.changeset(product, product_params)
    case Repo.update(changeset) do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "Product Updated successfully.")
        |> redirect(to: admin_products_path(conn, :edit, id))
      {:error, changeset} ->
        conn
        |> assign(:page_function_name, "Edit")
        |> put_flash(:error, "Something went wrong!")
        |> render("edit.html", changeset: changeset, product: product, page_function_name: conn.assigns.page_function_name)
    end
  end

  def delete(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    product = Repo.get(Product, id)
    case Repo.delete(product) do
      {:ok, _product} ->
        conn = put_flash(conn, :info, "Product deleted successfully.")
      {:error, changeset} ->
        conn = put_flash(conn, :error, "Something went wrong!")
    end
    redirect(conn, to: admin_products_path(conn, :index))
  end

  defp set_title(conn, _) do
    assign(conn, :title, "Product")
  end

  defp set_page_function_name(conn, _) do
    page_function_name = String.capitalize(Atom.to_string(action_name(conn)))
    assign(conn, :page_function_name, page_function_name)
  end
end
