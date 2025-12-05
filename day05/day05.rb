module MergeableRanges
  refine Range do
    def overlapping?(other) = min <= other.max && other.min <= max

    def merge(other) = ([min, other.min].min..[max, other.max].max)
  end
end

module Day05
  module_function

  using MergeableRanges

  def solve_one(...)
    parse(...) => ranges:, ingredients:

    ingredients.count { |ingredient| ranges.any? { it.cover?(ingredient) } }
  end

  def solve_two(...)
    parse(...) => ranges:
    merged_ranges = ranges.sort_by(&:min).each_with_object([]) do |curr, merged|
      curr = curr.merge(merged.pop) if merged[-1]&.overlapping?(curr)

      merged << curr
    end

    merged_ranges.sum(&:size)
  end

  def parse(input_filename)
    raw_ranges, raw_ingredients = File.read(input_filename).split("\n\n").map(&:split)
    ranges = raw_ranges.map do |range|
      start, fin = range.split("-").map(&:to_i)
      start..fin
    end

    { ranges:, ingredients: raw_ingredients.map(&:to_i) }
  end
end
