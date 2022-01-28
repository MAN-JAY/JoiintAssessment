defmodule Assessment.Exercise2 do
  import Assessment.Constants
  alias Assessment.Exercise2.{Troop, Sequence}

  def init(path) do
    advantage_map = get_advantage_map(path)
    exercise2_frame()

    IO.write("\nEnter the input: \n")

    IO.stream(:stdio, :line) |> Stream.take_while(&(&1 != "\n")) |> Enum.take(2)
    |> solve_exercise_2(advantage_map)

    IO.write("\n\nApplication Closed")
  end

  def solve_exercise_2(raw_input, advantage_map) do
    case read_input(raw_input) do
      {:ok, input} ->
        output =
          Sequence.get_all_sequences(input.my_troops, input.opp_troops, advantage_map)
          |> Sequence.pick_best_sequence()

        case output do
          {:ok, output} ->
            IO.write("\nOutput:\n")
            dsplay_output(output, input.opp_troops)

          {:error, msg} ->
            IO.write(msg)
        end

      {:error, msg} ->
        IO.write(msg)
    end
  end

  def read_input(raw_input) do
    case raw_input do
      [my_troop_raw, opp_troop_raw] ->
        my_troops = Troop.parse_troops(my_troop_raw)
        opp_troops = Troop.parse_troops(opp_troop_raw)

        if my_troops == :error && opp_troops == :error,
          do: {:error, error_input_e2()},
          else: {:ok, %{my_troops: my_troops, opp_troops: opp_troops}}

      _ ->
        {:error, error_input_e2()}
    end
  end

  def dsplay_output(output, opp_troops) do
    opp_troops
    |> Enum.map(fn troop ->
      my_troop =
        for battle <- output.battles,
            String.equivalent?(battle.opp_troop.platoon, troop.platoon) do
          Map.get(battle, :my_troop)
        end
        |> hd()

      my_troop.platoon <> "#" <> to_string(my_troop.units) <> "; "
    end)
    |> Enum.join()
    |> String.trim_trailing("; ")
    |> IO.write()
  end

  def get_advantage_map(path), do: File.read!(path) |> Poison.decode!()

  defp exercise2_frame() do
    Assessment.Utils.frame()
    IO.puts("\nEXERCISE 2\n")
  end
end
