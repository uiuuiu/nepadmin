require IEx
defmodule DateTimeConverterError do

  defexception message: "There are something wrong here!!!"

  def exception(assignments) do
    conn = assignments[:conn]
    conn
      |> Phoenix.Controller.put_flash(:error, [assignments[:message]])
        |> Phoenix.Controller.redirect(to: assignments[:path])
  end
end