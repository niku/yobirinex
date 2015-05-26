defmodule Webhoox do
  use Application

  def start(_type, _args) do
    Webhoox.Supervisor.start_link([])
  end
end
