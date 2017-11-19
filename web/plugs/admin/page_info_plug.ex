defmodule AdminManager.Plugs.Admin.PageInfoPlug do
  @moduledoc false
  import Plug.Conn

  def init(default) do
  end

  # def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
  #   assign(conn, :locale, loc)
  # end

  def call(conn, default) do
  end

  def set_title(conn, title \\ "========") do
    assign(conn, :title, title)
  end

  def set_page_function_name(conn, options \\ []) do
    page_function_name = String.capitalize(Atom.to_string(Phoenix.Controller.action_name(conn)))
    assign(conn, :page_function_name, page_function_name)
  end
end