defmodule EarmarkServer.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias EarmarkServer.Router

  @opts Router.init([])

  @markdown """
  # Hello, World!
  """

  describe "/render" do
    test "responds 200 with JSON payload containing rendered HTML" do
      conn =
        Router.call(
          conn(:get, "/render", text: @markdown),
          @opts
        )

      assert conn.state == :sent
      assert conn.status == 200

      assert Jason.decode!(conn.resp_body) == %{
               "name" => "Earmark",
               "version" => "1.3.2",
               "html" => "<h1>Hello, World!</h1>\n"
             }
    end

    test "responds 422 when the text param is not present" do
      conn =
        Router.call(
          conn(:get, "/render"),
          @opts
        )

      assert conn.state == :sent
      assert conn.status == 422

      assert Jason.decode!(conn.resp_body) == %{
               "error" => %{
                 "code" => 422,
                 "message" => "Missing 'text' param"
               }
             }
    end
  end

  describe "other paths" do
    test "responds 404" do
      conn =
        Router.call(
          conn(:get, "/foo"),
          @opts
        )

      assert conn.state == :sent
      assert conn.status == 404

      assert Jason.decode!(conn.resp_body) == %{
               "error" => %{
                 "code" => 404,
                 "message" => "Not Found"
               }
             }
    end
  end
end
