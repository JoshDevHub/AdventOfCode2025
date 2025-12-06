defmodule Day05 do
  def solve_one(filename) do
    %{ranges: ranges, ingredients: ingredients} = parse(filename)

    Enum.count(ingredients, fn ingredient ->
      Enum.any?(ranges, &(ingredient in &1))
    end)
  end

  def solve_two(filename) do
    %{ranges: ranges} = parse(filename)

    Enum.sort_by(ranges, &Enum.min/1)
    |> Enum.reduce([], &merge_ranges/2)
    |> Enum.sum_by(&Range.size/1)
  end

  def parse(filename) do
    [raw_ranges, raw_ingredients] = File.read!(filename)
      |> String.split("\n\n")
      |> Enum.map(&String.split/1)

    ranges = Enum.map(raw_ranges, fn range ->
      [start, stop] = String.split(range, "-") |> Enum.map(&String.to_integer/1)
      start..stop
    end)

    %{ranges: ranges, ingredients: Enum.map(raw_ingredients, &String.to_integer/1)}
  end

  defp merge_ranges(curr, []), do: [curr]
  defp merge_ranges(curr, [previous | rest]) do
    if not Range.disjoint?(curr, previous) do
      [merge_range(curr, previous) | rest]
    else
      [curr, previous | rest]
    end
  end

  defp merge_range(a, b), do: min(a.first, b.first)..max(a.last, b.last)
end
