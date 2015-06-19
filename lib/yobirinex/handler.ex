defmodule Yobirinex.Handler do
  require Logger
  import Plug.Conn

  def init([configdir: configdir]) do
    Logger.info("configdir: #{inspect configdir}")
    configfiles = Path.expand(configdir) |> Path.join("*.json") |> Path.wildcard
    Logger.info("configfiles: #{inspect configfiles}")
    for filename <- configfiles, into: Map.new do
      endpoint = Path.basename(filename, ".json")
      body = File.read!(filename) |> Poison.Parser.parse!
      {endpoint, body}
    end
  end

  def call(conn=%Plug.Conn{method: "POST", path_info: [path_info]}, configs) do
    Logger.info("Access to method: POST, path: #{inspect path_info}")
    config = Map.get(configs, path_info)
    Logger.debug("config: #{inspect config}")
    if config do
      execute(config)
      send_resp(conn, 200, "")
    else
      send_resp(conn, 404, "")
    end
  end

  def call(conn=%Plug.Conn{method: method, path_info: path_info}, _configs) do
    Logger.info("Access to method: #{inspect method}, path: #{inspect path_info}")
    send_resp(conn, 404, "")
  end

  def execute(config) do
    scripts = Map.fetch!(config, "scripts")
    commands = Enum.map(scripts, fn(script) ->
      command = Map.fetch!(script, "command")
      args = Map.get(script, "args", [])
      {command, args}
    end)

    Task.start(fn ->
      for {command, args} <- commands do
        Logger.debug("command: #{inspect command}, args: #{inspect args}")
        {result, status} = System.cmd(command, args)
        Logger.debug("status: #{inspect status}, result: #{inspect result}")
      end
    end)
  end
end
