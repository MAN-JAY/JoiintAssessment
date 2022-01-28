defmodule Assessment.Exercise2.Sequence do
  defstruct battles: [], win_percent: nil

  def get_sequence(battles), do: %__MODULE__{battles: battles}

  def calculate_win_percent(input) do
    total_win = Enum.count(input.battles, fn battle -> battle.result == :won end)
    win_percent = total_win / length(input.battles) * 100 |> Float.round(2)

    Map.put(input, :win_percent, win_percent)
  end
end
