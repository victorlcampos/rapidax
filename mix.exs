defmodule Rapidax.Mixfile do
  use Mix.Project

  def project do
    [app: :rapidax,
     version: "0.0.6",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     package: package]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
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
     {:httpoison, "~> 0.9.0"},
     {:poison, "~> 2.0"}]
  end

  defp package do
    [# These are the default files included in the package
     files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     maintainers: ["Victor Lima Campos"],
     licenses: ["Apache 2.0"],
     description: "Rapidly develop your API client - based on rapidash gem",
     links: %{"GitHub" => "https://github.com/victorlcampos/rapidax",
              "Issues" => "https://github.com/victorlcampos/rapidax/issues"}]
  end
end
