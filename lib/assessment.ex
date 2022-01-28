defmodule Assessment do
  def main(args) do
    options = [switches: [config: :string], aliases: [c: :config]]
    {opts, _, _} = OptionParser.parse(args, options)

    Assessment.Utils.frame()

    [selection] =
      ["\n", "Select the exercise number to continue:\n", "1. Exercise 1 \n", "2. Exercise 2 \n"]
      |> Enum.join()
      |> IO.gets()
      |> String.split(["\n"], trim: true)

    case selection |> Integer.parse() do
      {1, ""} ->
        Assessment.Exercise1.init()

      {2, ""} ->
        Assessment.Exercise2.init(opts[:config])

      _ ->
        [IO.ANSI.clear(), IO.ANSI.cursor(1, 1), 'Application Closed\n']
        |> Enum.join()
        |> IO.write()
    end
  end
end
