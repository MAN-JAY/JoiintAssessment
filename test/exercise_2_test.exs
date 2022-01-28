defmodule Exercise2Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Assessment.Constants
  alias Assessment.Exercise2
  alias Assessment.Exercise2.{Troop, Battle, Sequence}

  @advantage_map %{
    militia() => [spearmen(), light_cavalry()],
    spearmen() => [light_cavalry(), heavy_cavalry()],
    light_cavalry() => [foot_archer(), cavalry_archer()],
    heavy_cavalry() => [militia(), foot_archer(), light_cavalry()],
    cavalry_archer() => [spearmen(), heavy_cavalry()],
    foot_archer() => [militia(), cavalry_archer()]
  }

  test "parse advantage list" do
    assert Exercise2.get_advantage_map("advantage_map.json") == @advantage_map
  end

  describe "parse cli input" do
    setup do
      [
        cli_input: [
          "Spearmen#10; Militia#30; FootArcher#20; LightCavalry#1000; HeavyCavalry#120\n",
          "Militia#10; Spearmen#10; FootArcher#1000; LightCavalry#120; CavalryArcher#100"
        ],
        input_troop: %{
          my_troops: [
            %Troop{platoon: spearmen(), units: 10},
            %Troop{platoon: militia(), units: 30},
            %Troop{platoon: foot_archer(), units: 20},
            %Troop{platoon: light_cavalry(), units: 1000},
            %Troop{platoon: heavy_cavalry(), units: 120}
          ],
          opp_troops: [
            %Troop{platoon: militia(), units: 10},
            %Troop{platoon: spearmen(), units: 10},
            %Troop{platoon: foot_archer(), units: 1000},
            %Troop{platoon: light_cavalry(), units: 120},
            %Troop{platoon: cavalry_archer(), units: 100}
          ]
        }
      ]
    end

    test "read input and convert to map", fixture do
      assert Exercise2.read_input(fixture.cli_input) == {:ok, fixture.input_troop}
    end

    test "invalid input" do
      assert Exercise2.read_input("Error String") == {:error, error_input_e2()}
    end
  end

  describe "find the battle result" do
    setup do
      [
        battle1: %Battle{
          my_troop: %Troop{platoon: spearmen(), units: 100},
          opp_troop: %Troop{platoon: militia(), units: 100}
        },
        battle2: %Battle{
          my_troop: %Troop{platoon: spearmen(), units: 100},
          opp_troop: %Troop{platoon: heavy_cavalry(), units: 200}
        }
      ]
    end

    test "battle draw without advantage", fixture do
      assert Battle.get_result(fixture.battle1, @advantage_map) ==
               fixture.battle1 |> Map.put(:result, :draw)
    end

    test "battle lost without advantage", fixture do
      battle1 =
        fixture.battle1 |> Map.put(:opp_troop, Map.put(fixture.battle1.opp_troop, :units, 101))

      assert Battle.get_result(battle1, @advantage_map) == battle1 |> Map.put(:result, :lost)
    end

    test "battle won without advantage", fixture do
      battle1 =
        fixture.battle1 |> Map.put(:opp_troop, Map.put(fixture.battle1.opp_troop, :units, 99))

      assert Battle.get_result(battle1, @advantage_map) == battle1 |> Map.put(:result, :won)
    end

    test "battle draw with advantage", fixture do
      assert Battle.get_result(fixture.battle2, @advantage_map) ==
               fixture.battle2 |> Map.put(:result, :draw)
    end

    test "battle lost with advantage", fixture do
      battle2 =
        fixture.battle2 |> Map.put(:opp_troop, Map.put(fixture.battle2.opp_troop, :units, 201))

      assert Battle.get_result(battle2, @advantage_map) == battle2 |> Map.put(:result, :lost)
    end

    test "battle won with advantage", fixture do
      battle2 =
        fixture.battle2 |> Map.put(:opp_troop, Map.put(fixture.battle2.opp_troop, :units, 199))

      assert Battle.get_result(battle2, @advantage_map) == battle2 |> Map.put(:result, :won)
    end
  end

  describe "Calculate win percentage for a sequence" do
    setup do
      [
        sequences: %Sequence{
          battles: [
            %Battle{
              my_troop: %Troop{platoon: spearmen(), units: 15},
              opp_troop: %Troop{platoon: militia(), units: 14},
              result: :won
            },
            %Battle{
              my_troop: %Troop{platoon: militia(), units: 10},
              opp_troop: %Troop{platoon: spearmen(), units: 15},
              result: :won
            }
          ]
        }
      ]
    end

    test "find the win percentage for a particular sequence", fixture do
      assert Sequence.calculate_win_percent(fixture.sequences) ==
               fixture.sequences |> Map.put(:win_percent, 100)
    end
  end

  describe "calculate all possible sequences" do
    setup do
      [
        my_troops: [
          %Troop{platoon: spearmen(), units: 15},
          %Troop{platoon: militia(), units: 10}
        ],
        opp_troops: [
          %Troop{platoon: spearmen(), units: 15},
          %Troop{platoon: militia(), units: 14}
        ],
        sequences: [
          %Sequence{
            battles: [
              %Battle{
                my_troop: %Troop{platoon: spearmen(), units: 15},
                opp_troop: %Troop{platoon: spearmen(), units: 15},
                result: :draw
              },
              %Battle{
                my_troop: %Troop{platoon: militia(), units: 10},
                opp_troop: %Troop{platoon: militia(), units: 14},
                result: :lost
              }
            ],
            win_percent: 0.00
          },
          %Sequence{
            battles: [
              %Battle{
                my_troop: %Troop{platoon: spearmen(), units: 15},
                opp_troop: %Troop{platoon: militia(), units: 14},
                result: :won
              },
              %Battle{
                my_troop: %Troop{platoon: militia(), units: 10},
                opp_troop: %Troop{platoon: spearmen(), units: 15},
                result: :won
              }
            ],
            win_percent: 100.00
          }
        ],
        sequences_fail: [
          %Sequence{
            battles: [
              %Battle{
                my_troop: %Troop{platoon: spearmen(), units: 10},
                opp_troop: %Troop{platoon: militia(), units: 15},
                result: :lost
              },
              %Battle{
                my_troop: %Troop{platoon: militia(), units: 10},
                opp_troop: %Troop{platoon: spearmen(), units: 20},
                result: :draw
              }
            ],
            win_percent: 50.00
          },
          %Sequence{
            battles: [
              %Battle{
                my_troop: %Troop{platoon: militia(), units: 10},
                opp_troop: %Troop{platoon: militia(), units: 15},
                result: :lost
              },
              %Battle{
                my_troop: %Troop{platoon: spearmen(), units: 10},
                opp_troop: %Troop{platoon: spearmen(), units: 20},
                result: :lost
              }
            ],
            win_percent: 0.00
          }
        ],
        cli_output: "Militia#10; Spearmen#15"
      ]
    end

    test "find all possible sequences with win percentage data matrix", fixture do
      assert Sequence.get_all_sequences(fixture.my_troops, fixture.opp_troops, @advantage_map) ==
               fixture.sequences
    end

    test "find the best sequence possible success scenario", fixture do
      assert Sequence.pick_best_sequence(fixture.sequences) ==
               {:ok, fixture.sequences |> List.last()}
    end

    test "find the best sequence possible failure scenario", fixture do
      assert Sequence.pick_best_sequence(fixture.sequences_fail) == {:error, error_no_win()}
    end

    test "format output", fixture do
      assert capture_io(fn ->
               Exercise2.dsplay_output(List.last(fixture.sequences), fixture.opp_troops)
             end) == fixture.cli_output
    end
  end
end
