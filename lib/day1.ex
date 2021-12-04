defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  def depth_measurement_increases(input) do
    count_depth_measurement_increases(input, 0)
  end

  defp count_depth_measurement_increases([_last_number | []], count) do
    count
  end

  defp count_depth_measurement_increases([n1, n2 | rest], count) when n2 > n1 do
    count_depth_measurement_increases([n2 | rest], count + 1)
  end

  defp count_depth_measurement_increases([_n1, n2 | rest], count) do
    count_depth_measurement_increases([n2 | rest], count)
  end

  def three_measurement_window_sums(input, result \\ [])

  def three_measurement_window_sums([n1, n2, n3 | []], result) do
    [n1 + n2 + n3 | result] |> Enum.reverse()
  end

  def three_measurement_window_sums([n1, n2, n3 | rest], result) do
    three_measurement_window_sums([n2, n3 | rest], [n1 + n2 + n3 | result])
  end
end
