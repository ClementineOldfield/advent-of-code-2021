defmodule Day2 do
  @moduledoc """
  Documentation for `Day2`.
  """

  def position(instructions, horizontal \\ 0, depth \\ 0, aim \\ 0)

  def position([], horizontal, depth, _aim), do: %{horizontal: horizontal, depth: depth}

  def position(["up " <> <<digit::bytes-size(1)>> | rest], horizontal, depth, aim) do
    count = String.to_integer(digit)

    new_aim = aim - count

    position(rest, horizontal, depth, new_aim)
  end

  def position(["down " <> <<digit::bytes-size(1)>> | rest], horizontal, depth, aim) do
    count = String.to_integer(digit)

    new_aim = aim + count

    position(rest, horizontal, depth, new_aim)
  end

  def position(["forward " <> <<digit::bytes-size(1)>> | rest], horizontal, depth, aim) do
    count = String.to_integer(digit)

    new_horizontal_position = horizontal + count
    new_depth = depth + aim * count

    position(rest, new_horizontal_position, new_depth, aim)
  end

  def position(_, _, _, _), do: "Invalid instruction encountered"

  def parse_input do
    {:ok, file} = File.read("input.txt")

    file
    |> String.split("\n")
  end
end
