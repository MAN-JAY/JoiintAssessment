defmodule Assessment.Exercise2.Troop do
  defstruct platoon: "", units: nil

  def get_troop(platoon, units), do: %__MODULE__{platoon: platoon, units: units}
end
