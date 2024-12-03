defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "handles example file" do
    assert Day1.solve_from_file("inputs/day1_example", :part1) == {:ok, 11}
  end

  test "handles example file part 2" do
    assert Day1.solve_from_file("inputs/day1_example", :part2) == {:ok, 31}
  end

end
