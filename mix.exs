defmodule CampMinder.Mixfile do
  use Mix.Project

  def project do
    [app: :campminder,
     version: "0.0.1",
     description: "A CampMinder API library for Elixir.",
     package: package,
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(Mix.env)]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:httpoison, :timex],
      mod: { CampMinder, [] }
    ]
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
  defp deps(:dev) do
    deps(:prod)
  end

  defp deps(:test) do
    deps(:dev)
  end


  defp deps(:prod) do
    [
      {:httpoison, "~> 0.8.2" },
      {:hackney, "~> 1.5" },
      {:poison, "~> 2.1.0"},
      {:timex, "~> 2.1"},
      {:ex_doc, "~> 0.11.4", only: :dev},
      {:exvcr, "~> 0.7", only: :test}
    ]
  end

  def package do
    [
      maintainers: ["Andrew Anderson"],
      licenses: ["New BSD"],
      links: %{"GitHub" => "https://github.com/GimliLongBow/campminder-elixir"}
    ]
  end
end
