require IEx
defmodule AdminManager.Admin.ProducersController do
  use AdminManager.Web, :controller
  alias AdminManager.Producer
  plug :set_title
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
        conn = assign(conn, :page_function_name, "New")
        render(conn, "new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
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
    Repo.get(Producer, id)
    |> Producer.changeset(producer_params)
    |> Repo.update
    redirect(conn, to: admin_producers_path(conn, :edit, id))
  end

  defp set_title(conn, _) do
    assign(conn, :title, "Producer")
  end

  defp set_page_function_name(conn, _) do
    page_function_name = String.capitalize(Atom.to_string(action_name(conn)))
    assign(conn, :page_function_name, page_function_name)
  end
end
