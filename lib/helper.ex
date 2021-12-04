defmodule Helper do
  @doc """
  Reads the puzzle input from a given text file path.

  ## Examples

      iex> Day3.parse_input("test_input.txt")
      ["foo", "bar", "baz"]

  """
  def parse_input(path) do
    {:ok, file} = File.read(path)

    file
    |> String.split("\n")
  end
end
