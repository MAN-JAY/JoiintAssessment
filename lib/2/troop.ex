defmodule Assessment.Exercise2.Troop do
  defstruct platoon: "", units: nil

  def get_troop(platoon, units), do: %__MODULE__{platoon: platoon, units: units}

  
  def parse_troops(input) do
    output =
      input
      |> String.split(["; ", "\n"], trim: true)
      |> Enum.map(fn troop ->
        case String.split(troop, ["#"], trim: true) do
          [platoon, units] -> {units_int, _} = Integer.parse(units)
            get_troop(platoon, units_int)
          _ -> :error
        end
      end)

    if length(output) == 5 && !Enum.member?(output, :error), do: output, else: :error
  end
end
