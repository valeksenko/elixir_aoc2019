defmodule AoC2019.Day14.Part1Test do
  use ExUnit.Case
  doctest AoC2019.Day14.Part1
  import AoC2019.Day14.Part1
  import TestHelper

  test "runs for sample input" do
    assert 13312 == run(read_example(:day14))
    assert 180697 == run(read_example(:day14_1))
    assert 2210736 == run(read_example(:day14_2))
  end
end
