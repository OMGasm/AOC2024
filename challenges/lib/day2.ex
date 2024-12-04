defmodule Day2 do
  def solve_from_file(filename, part) do
    solver = case part do
      :part1 -> &is_line_safe?/1
      :part2 -> fn _ -> false end
    end
    res = File.stream!(filename, :line, encoding: :utf8)
    |> Stream.map(&String.split/1)
    |> Stream.map(&to_numbers/1)
    |> Stream.filter(solver)
    |> Enum.count
    {:ok, res}
  end

  def to_numbers list do
    Enum.map list, &String.to_integer/1
  end

  @doc """
  determine if a line is safe by meeting all the following criteria:
  - no two adjacent elements differ > 3
  - no two adjacent elements equal
  - the "direction" of change between elements must be the same
    - either always increasing OR
    - always decreasing
  ## Examples
  iex>  Day2.is_line_safe? [7, 6, 4, 2, 1]
  true

  iex>  Day2.is_line_safe? [1, 2, 7, 8, 9]
  false

  iex>  Day2.is_line_safe? [9, 7, 6, 2, 1]
  false

  iex>  Day2.is_line_safe? [1, 3, 2, 4, 5]
  false

  iex>  Day2.is_line_safe? [8, 6, 4, 4, 1]
  false

  iex>  Day2.is_line_safe? [1, 3, 6, 7, 9]
  true
  """
  def is_line_safe? list do
    [a, b] = Enum.take list, 2
    slope = a - b
    case abs slope do
      n when n in 1..3 -> check_line(list, div(slope, n))
      _ -> false
    end
  end

  def check_line(list, direction) do
    Stream.chunk_every(list, 2, 1, [Enum.at(list, -1) - direction])
    |> Stream.map(fn w -> Enum.reduce(w, &((&2 - &1) * direction)) end)
    |> Enum.all?(&(&1 in 1..3))
  end

end
