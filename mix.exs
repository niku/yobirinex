defmodule Yobirinex.Mixfile do
  use Mix.Project

  def project do
    [app: :yobirinex,
     version: "0.0.1",
     elixir: "~> 1.2",
     description: "A generic webhook endpoint that runs scripts (like the captainhook)",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     package: package]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :cowboy, :plug, :exrm_deb],
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
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:cowboy, "~> 1.0"},
     {:plug, "~> 1.1"},
     {:poison, "~> 2.1"},
     {:logger_file_backend, "~> 0.0.6"},
     {:exrm, "~> 1.0"},
     {:exrm_deb, "~> 0.0.4"}]
  end

  defp package do
    [external_dependencies: [],
     license_file: "LICENSE",
     maintainers: ["niku <niku@niku.name>"],
     vendor: "niku",
     licenses: ["MIT"],
     links: %{
       "GitHub" => "https://github.com/niku/yobirinex",
       "Homepage" => "https://github.com/niku/yobirinex"
     }]
  end
end
