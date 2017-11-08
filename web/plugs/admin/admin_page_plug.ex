defmodule AdminManager.Plugs.Admin.AdminPagePlug do
  @moduledoc false
  import Plug.Conn

  def init(default) do
  end

  # def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
  #   assign(conn, :locale, loc)
  # end

  def call(conn, default) do
    assign(conn, :locale, default)
  end
end