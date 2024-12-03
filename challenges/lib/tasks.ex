defmodule AocMac do
  defmacro __using__(_opts) do
    quote do
      @foo "bar!"
      import AocMac
    end
  end
  defmacro qq(name, do: block) do
    funcname = String.to_atom(name)
    quote do
      def unquote(funcname)(), do: unquote(block)
    end
  end
end

defmodule Mix.Tasks.Aoc do
  @foo "bar"
  @moduledoc """
  Runs AOC 2024 challenges
  #{@foo}
  """
  use Mix.Task

  @shortdoc "Gets day [n] result"
  def run([n]) do
    n = String.to_integer(n)
    solver = &Module.concat(["Day#{n}"]).solve_from_file("inputs/day#{n}", &1)
    Enum.map [:part1, :part2], fn part -> case solver.(part) do
        {:ok, res} -> IO.puts "#{part}: #{res}"
        {:error, err} -> IO.puts "#{part} ERROR: #{err}"
      end
    end
  end

  #def run([]) do
  #  IO.puts Mix.Tasks.Aoc.List.run([])
  #end


  defmodule List do
    use Mix.Task
    use AocMac

    @moduledoc "Generate AOC 2024 challenge listing#{@foo}"
    @shortdoc "List challenges"
    def run(_) do
      1..25 |> Enum.map(fn n -> { "Day#{n}", Kernel.function_exported?(String.to_atom("Day#{n}"), :solve_from_file, 2) } end) |> IO.inspect
    end

    qq "foo" do 1 end

  end
end

