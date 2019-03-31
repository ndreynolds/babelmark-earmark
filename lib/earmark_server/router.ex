defmodule EarmarkServer.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  get "/render" do
    conn = Plug.Conn.fetch_query_params(conn)

    case conn.query_params do
      %{"text" => markdown} ->
        send_resp(
          conn,
          200,
          Jason.encode!(render(markdown))
        )

      _ ->
        send_resp(
          conn,
          422,
          Jason.encode!(%{
            errors: ["Missing 'text' param"]
          })
        )
    end
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

  defp render(markdown) when is_binary(markdown) do
    {html, errors} =
      case Earmark.as_html(markdown) do
        {:ok, html, []} -> {html, []}
        {:error, html, errors} -> {html, errors}
      end

    %{
      name: "Earmark",
      version: to_string(Earmark.version()),
      html: html,
      errors: errors
    }
  end
end
