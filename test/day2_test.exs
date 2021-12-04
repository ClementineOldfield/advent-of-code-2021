defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  def test_instructions do
    ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]
  end

  # Part 1
  @tag :skip
  test "with test instructions" do
    assert %{horizontal: 15, depth: 10} = Day2.position(test_instructions())
  end

  # Part 2
  test "with test instructions using part 2 rules" do
    assert %{horizontal: 15, depth: 60} = Day2.position(test_instructions())
  end

  @tag :skip
  test "solution" do
    assert :solution = Day2.position(Helper.parse_input("day_2_input.txt"))
  end
end
