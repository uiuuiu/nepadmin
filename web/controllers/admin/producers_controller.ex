require IEx
defmodule AdminManager.Admin.ProducersController do
  use AdminManager.Web, :controller
  alias AdminManager.ErrorRenderOperation
  alias AdminManager.Admin.Producer.IndexOperation
  alias AdminManager.Admin.Producer.NewOperation
  alias AdminManager.Admin.Producer.CreateOperation
  alias AdminManager.Admin.Producer.ShowOperation
  alias AdminManager.Admin.Producer.EditOperation
  alias AdminManager.Admin.Producer.UpdateOperation
  alias AdminManager.Admin.Producer.DeleteOperation

  import AdminManager.Plugs.Admin.PageInfoPlug

  plug :set_title, "Producer"
  plug :set_page_function_name

  def index(conn, _params) do
    producers = IndexOperation.call
    render(conn, "index.html", producers: producers, title: conn.assigns.title, page_function_name: "List")
  end

  def new(conn, _params) do
    changeset = NewOperation.call
    render(conn, "new.html", changeset: changeset, page_function_name: conn.assigns.page_function_name)
  end

  def create(conn, %{"producer" => producer_params}) do
    create_producer = CreateOperation.call(producer_params)
    case create_producer do
      {:ok, _producer} ->
        conn
          |> put_flash(:info, "Producer created successfully.")
            |> redirect(to: admin_producers_path(conn, :index))
      {:error, changeset} ->
        errors = ErrorRenderOperation.render_multi_errors(changeset)
        conn
          |> put_flash(:error, errors)
            |> redirect(to: admin_producers_path(conn, :new))
    end
  end

  def show(conn, %{"id" => id}) do
    producer = ShowOperation.call(id)
    render(conn, "show.html", producer: producer, page_function_name: conn.assigns.page_function_name)
  end

  def edit(conn, %{"id" => id}) do
    {changeset, producer} = EditOperation.call(id)
    render(conn, "edit.html", changeset: changeset, producer: producer, page_function_name: conn.assigns.page_function_name)
  end

  def update(conn, %{"id" => id, "producer" => producer_params}) do
    update_producer = UpdateOperation.call(id, producer_params)
    case update_producer do
      {:ok, _producer} ->
        conn
          |> put_flash(:info, "Producer Updated successfully.")
            |> redirect(to: admin_producers_path(conn, :index))
      {:error, changeset} ->
        errors = ErrorRenderOperation.render_multi_errors(changeset)
        conn
          |> put_flash(:error, errors)
            |> redirect(to: admin_producers_path(conn, :edit, id))
    end
  end

  def delete(conn, %{"id" => id}) do
    delete_producer = DeleteOperation.call(id)
    case delete_producer do
      {:ok, _product} ->
        conn = put_flash(conn, :info, "Producer deleted successfully.")
      {:error, changeset} ->
        conn = put_flash(conn, :error, "Something went wrong!")
    end
    redirect(conn, to: admin_producers_path(conn, :index))
  end
end
