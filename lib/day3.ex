defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.
  """

  @doc """

      iex> Day3.power_consumption(["00100", "11110", "10110", "10111", "10101", "01111", "00111", "11100", "10000", "11001", "00010", "01010"])
      198

  """
  def power_consumption(input) do
    bit_count = bit_count(input)

    gamma =
      :gamma
      |> rate(bit_count, length(input))
      |> parse_binary_string()

    epsilon =
      :epsilon
      |> rate(bit_count, length(input))
      |> parse_binary_string()

    gamma * epsilon
  end

  defp parse_binary_string(binary_string) do
    case Integer.parse(binary_string, 2) do
      {integer, _} ->
        integer

      :error ->
        {:error, "unable to parse #{binary_string}"}
    end
  end

  @doc """

      iex> Day3.life_support_rating(["00100", "11110", "10110", "10111", "10101", "01111", "00111", "11100", "10000", "11001", "00010", "01010"])
      230

  """
  def life_support_rating(input) do
    oxygen_generator_rating = diagnostic_rating(:gamma, input)
    co2_scrubber_rating = diagnostic_rating(:epsilon, input)

    oxygen_generator_rating * co2_scrubber_rating
  end

  @doc """

  ## Examples

      iex> Day3.diagnostic_rating(:gamma, ["00100", "11110", "10110", "10111", "10101", "01111", "00111", "11100", "10000", "11001", "00010", "01010"])
      23

      iex> Day3.diagnostic_rating(:epsilon, ["00100", "11110", "10110", "10111", "10101", "01111", "00111", "11100", "10000", "11001", "00010", "01010"])
      10


  """

  def diagnostic_rating(type, input, filtered_list \\ [])

  def diagnostic_rating(type, input, filtered_list) do
    bit_count = bit_count(input)
    gamma_rate = rate(type, bit_count, length(input))

    diagnostic_rating(type, input, filtered_list, gamma_rate, 0)
  end

  def diagnostic_rating(_, [], [last_remaining], _, _),
    do: parse_binary_string(last_remaining)

  def diagnostic_rating(type, [], filtered_list, _, bit_position) do
    bit_count = bit_count(filtered_list)
    gamma_rate = rate(type, bit_count, length(filtered_list))

    diagnostic_rating(type, filtered_list, [], gamma_rate, bit_position + 1)
  end

  def diagnostic_rating(type, [binary | rest], filtered_list, gamma_rate, bit_position) do
    diagnostic_rating(
      type,
      rest,
      filter_binary(
        String.at(binary, bit_position),
        String.at(gamma_rate, bit_position),
        binary,
        filtered_list
      ),
      gamma_rate,
      bit_position
    )
  end

  defp filter_binary(bit, gamma_bit, binary, filtered_list) when bit == gamma_bit do
    [binary | filtered_list]
  end

  defp filter_binary(_, _, _, filtered_list) do
    filtered_list
  end

  @doc """
  determines the count of each column of bits

  ## Examples

      iex> Day3.bit_count(["00100", "11110", "10110", "10111", "10101", "01111", "00111", "11100", "10000", "11001", "00010", "01010"])
      [7, 5, 8, 7, 5]

  """

  def bit_count([first | rest]), do: bit_count(rest, split_binary_string(first))

  def bit_count([], result), do: result

  def bit_count([num | rest], result) do
    bit_count(rest, combine_counts(split_binary_string(num), result))
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
      "10110"

      iex> Day3.rate(:epsilon, [7, 5, 8, 7, 5], 12)
      "01001"

  """

  def rate(type, counts, input_length, result \\ [])

  def rate(_type, [], _, result) do
    result
    |> Enum.reverse()
    |> Enum.join()
  end

  def rate(type, [count | rest], input_length, result) do
    rate(type, rest, input_length, [rate_bit(type, count, input_length / 2) | result])
  end

  defp rate_bit(:gamma, count, limit) when count >= limit, do: 1
  defp rate_bit(:epsilon, count, limit) when count < limit, do: 1
  defp rate_bit(_type, _count, _limit), do: 0
end
