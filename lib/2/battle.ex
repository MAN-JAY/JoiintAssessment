defmodule Assessment.Exercise2.Battle do
  defstruct my_troop: nil, opp_troop: nil, result: nil

  def get_troop(my_troop, opp_troop), do: %__MODULE__{my_troop: my_troop, opp_troop: opp_troop}

  def get_result(advantage_map, battle) do
    adv_platoon = Map.get(advantage_map, battle.my_troop.platoon)

    my_troop_units =
      if Enum.member?(adv_platoon, battle.opp_troop.platoon),
        do: battle.my_troop.units * 2,
        else: battle.my_troop.units
   
    cond do
      my_troop_units > battle.opp_troop.units -> Map.put(battle, :result, :won)
      my_troop_units == battle.opp_troop.units -> Map.put(battle, :result, :draw)
      my_troop_units < battle.opp_troop.units -> Map.put(battle, :result, :lost)
    end
  end
end
