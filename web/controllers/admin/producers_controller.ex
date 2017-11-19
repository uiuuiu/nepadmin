require IEx
defmodule AdminManager.Admin.ProducersController do
  use AdminManager.Web, :controller
  alias AdminManager.Producer

  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Producer" when action in [:index, :show, :new, :edit]
  plug :set_page_function_name

  def index(conn, _params) do
    page_function_name = "List"
    producers = Producer
      |> Repo.all
    render(conn, "index.html", producers: producers, title: conn.assigns.title, page_function_name: page_function_name)
  end

  def new(conn, _params) do
    changeset = Producer.changeset(%Producer{})
    render(conn, "new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
  end

  def create(conn, %{"producer" => producer_params}) do
    changeset = Producer.changeset(%Producer{}, producer_params)
    case Repo.insert(changeset) do
      {:ok, _producer} ->
        conn
          |> put_flash(:info, "Producer created successfully.")
            |> redirect(to: admin_producers_path(conn, :index))
      {:error, changeset} ->
        conn
          |> assign(:page_function_name, "New")
            |> render("new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
    end
  end

  def show(conn, %{"id" => id}) do
    producer = Repo.get(Producer, id)
    render(conn, "show.html", producer: producer, page_function_name: conn.assigns.page_function_name)
  end

  def edit(conn, %{"id" => id}) do
    producer = Repo.get(Producer, id)
    changeset = Producer.changeset(%Producer{}, %{name: producer.name})
    render(conn, "edit.html", changeset: changeset, producer: producer, page_function_name: conn.assigns.page_function_name)
  end

  def update(conn, %{"id" => id, "producer" => producer_params}) do
    producer = Repo.get(Producer, id)
    changeset = Producer.changeset(producer, producer_params)
    case Repo.update(changeset) do
      {:ok, _producer} ->
        conn
          |> put_flash(:info, "Producer Updated successfully.")
            |> redirect(to: admin_producers_path(conn, :edit, id))
      {:error, changeset} ->
        conn
          |> assign(:page_function_name, "Edit")
            |> put_flash(:error, "Something went wrong!")
              |> render("edit.html", changeset: changeset, producer: producer, page_function_name: conn.assigns.page_function_name)
    end
  end

  def delete(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    producer = Repo.get(Producer, id)
    case Repo.delete(producer) do
      {:ok, _product} ->
        conn = put_flash(conn, :info, "Producer deleted successfully.")
      {:error, changeset} ->
        conn = put_flash(conn, :error, "Something went wrong!")
    end
    redirect(conn, to: admin_producers_path(conn, :index))
  end
end
