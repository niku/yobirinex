defmodule Yobirinex.Mixfile do
  use Mix.Project

  def project do
    [app: :yobirinex,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :cowboy, :plug],
     included_applications: [:poison, :logger_file_backend],
     mod: {Yobirinex, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:cowboy, "~> 1.0"},
     {:plug, "~> 1.0"},
     {:poison, "~> 1.5"},
     {:logger_file_backend, "~> 0.0.4"},
     {:exrm, "~> 0.19"}]
  end
end
