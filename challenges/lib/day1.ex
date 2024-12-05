defmodule Day1 do

  @doc """
  ## Examples
    iex> left = [3, 4, 2, 1, 3, 3]
    iex> right = [4, 3, 5, 3, 9, 3]
    iex> Day1.solve {left, right}
    11
  """
  def solve {left, right} do
    left = Enum.sort left
    right = Enum.sort right
    result = Enum.zip_reduce left, right, 0, fn a, b, acc -> acc + abs(a - b) end
    result
  end

  @doc """
  ## Examples
    iex> left = [3, 4, 2, 1, 3, 3]
    iex> right = [4, 3, 5, 3, 9, 3]
    iex> Day1.solve_part2 {left, right}
    31
  """
  def solve_part2 {left, right} do
    right = Enum.frequencies right
    Enum.reduce left, 0, fn n, acc -> acc + n * (right[n] || 0) end
  end

  def solve_from_file(file_name, part) do
    case File.open file_name do
      {:ok, file} ->
        lists = IO.stream(file, :line) |> process_lines
        File.close file
        case part do
          :part1 -> {:ok, solve lists}
          :part2 -> {:ok, solve_part2 lists}
          _ -> {:error, "invalid part"}
        end
      err -> err
    end
  end

  def process_lines(stream) do
    stream
    |> Stream.map(&split_to_tuples/1)
    |> Stream.map(&convert_to_numbers/1)
    |> Enum.unzip
  end

  def split_to_tuples(line) do
    line
    |> String.split
    |> assert_two_items
    |> List.to_tuple
  end

  def convert_to_numbers {a, b} do
    { String.to_integer(a), String.to_integer(b) }
  end

  def assert_two_items(pair = [_, _]) do pair end
  def assert_two_items list do raise ArgumentError, message: "does not contain two items [#{length(list)}]" end
end
