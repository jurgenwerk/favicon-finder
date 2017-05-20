defmodule FaviconFinder.Mixfile do
  use Mix.Project

  def project do
    [app: :favicon_finder,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps(),
     name: "Favicon Finder",
     source_url: "https://github.com/matixmatix/favicon-finder"
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.11.1"},
      {:floki, "~> 0.17.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    """
    Extract favicon links from websites.
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :favicon_finder,
      maintainers: ["Matic Jurglic"],
      licenses: ["😂"],
      links: %{"GitHub" => "https://github.com/matixmatix/favicon-finder"}
    ]
  end
end
