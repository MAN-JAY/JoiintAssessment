defmodule Assessment.MixProject do
  use Mix.Project

  def project do
    [
      app: :assessment,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      escript: [main_module: Assessment],
      preferred_cli_env: [
        coveralls: :test
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1"},
      {:excoveralls, "~> 0.14.4"}
    ]
  end
end
