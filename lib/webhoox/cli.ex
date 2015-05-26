defmodule Webhoox.CLI do
  def main(args) do
    args |> parse_args |> process
  end

  def process({webhook_options, cowboy_options}) do
    Plug.Adapters.Cowboy.http Webhoox, webhook_options, cowboy_options
    # Avoid halting after the application started
    # http://stackoverflow.com/a/30075166/1291022
    :timer.sleep(:infinity)
  end

  def parse_args(args) do
    case OptionParser.parse(args) do
      {parsed, [argv], _errors} -> {[configdir: argv], parsed}
      _ ->
        IO.puts "Webhook take only one argument following like:\n./webhoox ~/configdir"
        exit(:normal)
    end
  end
end
