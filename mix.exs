defmodule Setaria.Mixfile do
  use Mix.Project

  def project do
    [app: :setaria,
     version: "0.2.0",
     elixir: "~> 1.3.4",
     # build_embedded: Mix.env == :prod,
     # start_permanent: Mix.env == :prod,
     description: "Setaria is OATH One Time Passwords Library for Elixir.",
     package: [
       maintainers: ["Ryo Ito"],
       licenses: ["MIT"],
       links: %{"GitHub" => "https://github.com/ritou/elixir-setaria"}
     ],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
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
    [
      {:pot, "~>0.9.5"},
      {:ex_doc, "~> 0.10", only: :dev}
    ]
  end
end
