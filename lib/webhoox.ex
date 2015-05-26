defmodule Webhoox do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Webhoox.Handler, [configdir: "~/configdir"], [])
    ]

    opts = [strategy: :one_for_one, name: Webhoox.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
