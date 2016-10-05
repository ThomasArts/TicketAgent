defmodule Tickets.Mixfile do
  use Mix.Project

  def project do
    [app: :tickets,
     version: "0.1.0",
     elixir: "~> 1.3",
     test_pattern: "*_{test,eqc}.exs",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    []
  end

  defp deps do
    [{:eqc_ex, "~> 1.3.2"}]
  end
end
