defmodule AdminManager.ErrorRenderOperation do

  def render_multi_errors(changeset) do
    Enum.map(changeset.errors, fn {field_error, error_message} ->
          render_detail(error_message)
        end)
  end

  defp render_detail({message, values}) do
    Enum.reduce values, message, fn {k, v}, acc ->
      String.replace(acc, "%{#{k}}", to_string(v))
    end
  end

  defp render_detail(message) do
    message
  end
end
