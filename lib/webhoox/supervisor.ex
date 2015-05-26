defmodule Webhoox.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts)
  end

  def init(_opts) do
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Webhoox.Handler, [configdir: "~/configdir"], [])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
