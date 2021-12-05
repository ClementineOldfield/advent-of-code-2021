defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "solution" do
    assert :solution == Day3.power_consumption(Helper.parse_input("day_3_input.txt"))
  end
end
