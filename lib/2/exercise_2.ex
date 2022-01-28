defmodule Assessment.Exercise2 do
  import Assessment.Constants
  alias Assessment.Exercise2.{Troop}

  def init(path) do
    advantage_map = get_advantage_map(path)
    exercise2_frame(advantage_map)

    case read_input() do
      {:ok, input} -> IO.write("Read successful")
      {:error, msg} -> IO.write(msg)
    end
  end

  def read_input() do
    IO.write("\nEnter the input: \n")

    case IO.stream(:stdio, :line) |> Stream.take_while(&(&1 != "\n")) |> Enum.take(2) do
      [my_troop_raw, opp_troop_raw] ->
        my_troops = parse_troops(my_troop_raw)
        opp_troops = parse_troops(opp_troop_raw)

        if my_troops == :error && opp_troops == :error,
          do: {:error, error_input_e2()},
          else: {:ok, %{my_troops: my_troops, opp_troops: opp_troops}}

      _ ->
        {:error, error_input_e2()}
    end
  end

  defp parse_troops(input) do
    output =
      input
      |> String.split(["; "], trim: true)
      |> Enum.map(fn troop ->
        case String.split(troop, ["#"], trim: true) do
          [platoon, units] -> Troop.get_troop(platoon, units)
          _ -> :error
        end
      end)

    if length(output) == 5 && !Enum.member?(output, :error), do: output, else: :error
  end

  def get_advantage_map(path), do: File.read!(path)

  def exercise2_frame(advantage_map) do
    Assessment.Utils.frame()
    IO.puts("\nEXERCISE 2\n")
    ["\n", "   Advantage Map: ", advantage_map, "\n"] |> Enum.join() |> IO.write()
  end
end
