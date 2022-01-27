defmodule AssessmentTest do
  use ExUnit.Case
  doctest Assessment

  test "greets the world" do
    assert Assessment.hello() == :world
  end
end
