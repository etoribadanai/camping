defmodule Camping.Plugs.RequestParams do
  use Plug.Builder

  plug Plug.Logger
  plug :valid_filters

  def valid_filters(conn, params) do
    filters = Enum.filter(conn.params, fn {k, _v} -> Enum.member?(params, k) end)
    conn |> assign(:filters, filters)
  end
end
