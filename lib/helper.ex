defmodule Helper do
  @doc """
  Reads the puzzle input from a given text file path.

  ## Examples

      iex> Helper.parse_input("test_input.txt")
      ["foo", "bar", "baz"]

  """
  def parse_input(path, format \\ :string)

  def parse_input(path, :string) do
    {:ok, file} = File.read(path)

    file
    |> String.split("\n")
  end

  def parse_input(path, :integer) do
    parse_input(path, :string)
    |> Enum.map(&String.to_integer/1)
  end

  def parse_input(_path, format), do: {:error, "unknown format: #{format}"}
end
