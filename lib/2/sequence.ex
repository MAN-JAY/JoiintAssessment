defmodule Assessment.Exercise2.Sequence do
  alias Assessment.{Utils, Constants}
  alias Assessment.Exercise2.Battle

  defstruct battles: [], win_percent: nil

  def get_sequence(battles), do: %__MODULE__{battles: battles}

  def calculate_win_percent(input) do
    total_win = Enum.count(input.battles, fn battle -> battle.result == :won end)
    win_percent = (total_win / length(input.battles) * 100) |> Float.round(2)

    Map.put(input, :win_percent, win_percent)
  end

  def get_all_sequences(my_troops, opp_troops, advantage_map) do
    opp_troops
    |> Utils.posibilities(length(opp_troops))
    |> Enum.map(fn posibility ->
      battles =
        Enum.zip(my_troops, posibility)
        |> Enum.map(fn {my_troop, opp_troop} ->
          Battle.get_battle(my_troop, opp_troop) |> Battle.get_result(advantage_map)
        end)

      battles |> get_sequence() |> calculate_win_percent()
    end)
  end

  def pick_best_sequence(seq_list) do
    best_seq = seq_list
    |> Enum.sort_by(&(&1.win_percent), :desc)
    |> hd()

    if best_seq.win_percent > 60, do: {:ok, best_seq}, else: {:error, Constants.error_no_win()}
  end
end
