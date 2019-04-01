defmodule EarmarkServer.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  get "/render" do
    conn = Plug.Conn.fetch_query_params(conn)

    case conn.params do
      %{"text" => markdown} ->
        send_json_resp(conn, 200, babelmark_payload(markdown))

      _ ->
        send_json_resp(
          conn,
          422,
          error_payload(422, "Missing 'text' param")
        )
    end
  end

  match _ do
    send_json_resp(
      conn,
      404,
      error_payload(404, "Not Found")
    )
  end

  defp babelmark_payload(markdown) when is_binary(markdown) do
    rendered_html =
      case Earmark.as_html(markdown) do
        {:ok, html, []} -> html
        {:error, html, _errors} -> html
      end

    %{
      name: "Earmark",
      version: to_string(Earmark.version()),
      html: rendered_html
    }
  end

  defp error_payload(code, message) do
    %{
      error: %{code: code, message: message}
    }
  end

  defp send_json_resp(conn, status, payload) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(status, Jason.encode!(payload))
  end
end
