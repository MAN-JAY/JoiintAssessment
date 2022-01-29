defmodule AssessmentTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Assessment.Constants

  test "cli app frame with banner" do
    assert capture_io(fn -> Assessment.Utils.frame() end) ==
             ['\e[2J\e[1;1H', joiint_banner(), '\n', 'Assessment | Joiint\n'] |> Enum.join()
  end
end
