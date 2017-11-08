require IEx
defmodule AdminManager.Admin.ProductDetailView do
  use AdminManager.Web, :view

  def render("scripts.html", _assigns) do
    ~s{<script>require("web/static/js/admin/product_detail").ProductDetail.run()</script>}
    |> raw
  end
end
