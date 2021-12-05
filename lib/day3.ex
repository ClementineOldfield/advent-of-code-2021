defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.
  """

  @doc """

      iex> Day3.power_consumption(["00100", "11110", "10110", "10111", "10101", "01111", "00111", "11100", "10000", "11001", "00010", "01010"])
      198

  """
  def power_consumption(input) do
    count = count(input)

    gamma = rate(:gamma, count, length(input))
    epsilon = rate(:epsilon, count, length(input))

    gamma * epsilon
  end

  @doc """
  determines the count of each column of bits

  ## Examples

      iex> Day3.count(["00100", "11110", "10110", "10111", "10101", "01111", "00111", "11100", "10000", "11001", "00010", "01010"])
      [7, 5, 8, 7, 5]

  """

  def count([first | rest]), do: count(rest, split_binary_string(first))

  def count([], result), do: result

  def count([num | rest], result) do
    count(rest, combine_counts(split_binary_string(num), result))
  end

  @doc """

  ## Examples

      iex> Day3.combine_counts([1, 0, 1, 1, 1], [1, 2, 0, 1, 1])
      [2, 2, 1, 2, 2]

  """

  def combine_counts(list1, list2, result \\ [])

  def combine_counts([], [], result), do: Enum.reverse(result)

  def combine_counts([l1_el | l1_rest], [l2_el | l2_rest], result) do
    combine_counts(l1_rest, l2_rest, [l1_el + l2_el | result])
  end

  @doc """

  ## Examples

      iex> Day3.split_binary_string("10111")
      [1, 0, 1, 1, 1]

  """

  def split_binary_string(string) do
    string
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  @doc """

  ## Examples

      iex> Day3.rate(:gamma, [7, 5, 8, 7, 5], 12)
      22

      iex> Day3.rate(:epsilon, [7, 5, 8, 7, 5], 12)
      9

  """

  def rate(type, counts, input_length, result \\ [])

  def rate(_type, [], _, result) do
    case result
         |> Enum.reverse()
         |> Enum.join()
         |> Integer.parse(2) do
      {integer, _} ->
        integer

      error ->
        error
    end
  end

  def rate(type, [count | rest], input_length, result) do
    rate(type, rest, input_length, [rate_bit(type, count, input_length / 2) | result])
  end

  defp rate_bit(:gamma, count, limit) when count > limit, do: 1
  defp rate_bit(:epsilon, count, limit) when count < limit, do: 1
  defp rate_bit(_type, _count, _limit), do: 0
end
