defmodule AdminManager.Plugs.Admin.PageNavigatorPlug do
  @moduledoc false
  import Plug.Conn

  def init(default) do
  end

  # def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
  #   assign(conn, :locale, loc)
  # end

  def call(conn, default) do
  end

  def redirect_back(conn, opts \\ []) do
    Phoenix.Controller.redirect(conn, to: NavigationHistory.last_path(conn, opts))
  end
end