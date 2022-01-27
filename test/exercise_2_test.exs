defmodule Exercise2Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Assessment.Constants
  alias Assessment.Exercise2

  @advantage_map %{
    militia: [spearmen, light_cavalry],
    spearmen: [light_cavalry, heavy_cavalry],
    light_cavalry: [foot_archer, cavalry_archer],
    heavy_cavalry: [militia, foot_archer, light_cavalry],
    cavalry_archer: [spearmen, heavy_cavalry],
    foot_archer: [militia, cavalry_archer]
  }

  @cli_input "Spearmen#10; Militia#30; FootArcher#20; LightCavalry#1000; HeavyCavalry#120\n" +
               "Militia#10; Spearmen#10; FootArcher#1000; LightCavalry#120; CavalryArcher#100"

  @input_troop %{
    my_troops: [
      %Troop{platoon: spearmen, units: 10},
      %Troops{platoon: militia, units: 30},
      %Troops{platoon: foot_archer, units: 20},
      %Troops{platoon: light_cavalry, units: 1000},
      %Troops{platoon: heavy_cavalry, units: 120}
    ],
    opp_troops: [
      %Troop{platoon: militia, units: 10},
      %Troops{platoon: spearmen, units: 10},
      %Troops{platoon: foot_archer, units: 1000},
      %Troops{platoon: light_cavalry, units: 120},
      %Troops{platoon: cavalry_archer, units: 100}
    ]
  }

  test "parse advantage list" do
    assert Exercise2.get_advantage_map() == @advantage_map
  end

  describe "parse cli input" do
    test "read input and convert to map" do
      assert capture_io(@cli_input, fn ->
               Exercise2.read_input()
             end) == @input_troop
    end

    test "invalid input" do
      assert capture_io("Error String", fn ->
               Exercise2.read_input()
             end) == error_input_e2
    end
  end
end
