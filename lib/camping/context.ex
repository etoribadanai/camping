require IEx

defmodule Camping.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  alias Camping.Repo
  alias Camping.Accounts.Schemas.User
  alias Camping.Accounts.Schemas.Social

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        conn
        |> assign(:signed_in, true)
        |> assign(:signed_user, context.current_user)

      _ ->
        conn
        |> send_resp(401, "Unauthorized")
        |> halt()
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- authorize(token) do
      {:ok, %{current_user: current_user, token: token}}
    end
  end

  defp authorize(token, schema \\ User) do
    schema
    |> where(token: ^token)
    |> Repo.one()
    |> authorized_user(schema, token)
  end

  defp authorized_user(_user = nil, schema, token) do
    case schema do
      User -> authorize(token, Social)
      Social -> {:error, "Invalid authorization token"}
    end
  end

  defp authorized_user(user, _, _), do: {:ok, user}
end
