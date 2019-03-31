defmodule EarmarkServer.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: EarmarkServer.Router,
        options: [port: port()]
      )
    ]

    opts = [
      strategy: :one_for_one,
      name: EarmarkServer.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end

  defp port do
    case System.get_env("PORT") do
      nil -> 4000
      raw -> raw |> Integer.parse() |> elem(0)
    end
  end
end
