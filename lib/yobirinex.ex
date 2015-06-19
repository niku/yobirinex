defmodule Yobirinex do
  use Application

  def start(_type, _args) do
    Yobirinex.Supervisor.start_link([])
  end
end
