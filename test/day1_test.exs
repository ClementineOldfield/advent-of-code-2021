defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "counts number of increases" do
    assert Day1.depth_measurement_increases([199, 200, 208, 210, 200, 207, 240, 269, 260, 263]) ==
             7
  end

  @tag :skip
  test "solution" do
    assert :solution ==
             "day_1_input.txt"
             |> Day1.parse_input()
             |> Day1.three_measurement_window_sums()
             |> Day1.depth_measurement_increases()
  end

  test "creates a list of 3 measurement window sums" do
    assert Day1.three_measurement_window_sums([199, 200, 208, 210, 200, 207, 240, 269, 260, 263]) ==
             [607, 618, 618, 617, 647, 716, 769, 792]
  end
end
