defmodule DefaultError do

  defexception message: "There are something wrong here!!!"

  def exception(assignments) do
    conn = assignments[:conn]
    conn
      |> Phoenix.Controller.put_flash(:error, ["There are something wrong here!!!"])
        |> Phoenix.Controller.redirect(to: assignments[:path])
  end
end