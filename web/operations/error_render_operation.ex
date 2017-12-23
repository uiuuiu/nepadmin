require IEx
defmodule AdminManager.ErrorRenderOperation do

  def render_multi_errors(changeset) do
    Enum.map(changeset.errors, fn {field_error, error_message} ->
          render_detail(field_error, error_message)
        end)
  end

  defp render_detail(field_error, {message, values}) do
    "#{field_error}: #{message}"
  end

  # defp render_detail(message) do
  #   message
  # end
end
