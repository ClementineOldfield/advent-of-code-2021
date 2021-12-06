defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  @tag :skip
  test "solution" do
    assert :solution == Day3.life_support_rating(Helper.parse_input("day_3_input.txt"))
  end
end
