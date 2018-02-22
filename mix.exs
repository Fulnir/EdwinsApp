defmodule EdwinApp.Mixfile do
  use Mix.Project

  def project do
    [
      app: :edwin_app,
<<<<<<< HEAD
      version: "0.0.4",
=======
      version: "0.0.3",
>>>>>>> wieder mit ignore
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {EdwinApp.Application, []},
      extra_applications: [:logger, :runtime_tools,
      # extra_application Add edeliver to the END of the list
      :edeliver]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:prometheus_ex, "~> 1.0"},
      {:prometheus_phoenix, "~> 1.0"},
      {:prometheus_plugs, "~> 1.0"},
      {:prometheus_process_collector, "~> 1.0"},
      {:distillery, "~> 1.5", warn_missing: false},
      {:edeliver, "~> 1.4"}
    ]
  end
end
