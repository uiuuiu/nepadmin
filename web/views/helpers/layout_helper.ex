require IEx
defmodule AdminManager.LayoutHelper do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  use Phoenix.HTML
  def one_card_page_content_tag(page_function_name, do: block) do
    content_tag(:section, class: "forms") do
      content_tag(:div, class: "container-fluid") do
        content_tag(:div, class: "col-lg-12") do
          content_tag(:div, class: "card") do
            [
              content_tag(:div, class: "card-header d-flex align-items-center") do
                content_tag(:span, page_function_name)
              end,
              content_tag(:div, class: "card-body") do
                block
              end
            ]
          end
        end
      end
    end
  end

  def admin_error_tag(info, errors) do
    content_tag(:div, class: "row") do
      content_tag(:div, class: "col-sm-12") do
        [
          if info do
            content_tag(:div, class: "alert alert-info", role: "alert") do
              content_tag(:p, info)
            end
          else
            ""
          end,
          if errors do
            content_tag(:div, class: "alert alert-danger", role: "alert") do
              for error <- errors do
                content_tag(:p, error)
              end
            end
          else
            ""
          end
        ]
      end
    end
  end
end
