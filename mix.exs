defmodule EarmarkServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :earmark_server,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {EarmarkServer.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.1"},
      {:earmark, "~> 1.3"}
    ]
  end
end
