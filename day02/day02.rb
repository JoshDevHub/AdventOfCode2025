module Day02
  module_function

  def solve_one(input_filename)
    ranges = build_id_ranges(input_filename)
    ranges.sum { it.sum_by_condition(&:two_substrings?) }
  end

  def solve_two(input_filename)
    ranges = build_id_ranges(input_filename)
    ranges.sum { it.sum_by_condition(&:repeated_substrings?) }
  end

  def parse(input_filename) = File.read(input_filename).split(",")

  def build_id_ranges(input_filename)
    parse(input_filename).map do |raw_range|
      start, fin = raw_range.split("-")
      IdRange.new(start, fin)
    end
  end

  class IdRange
    def initialize(start, fin)
      @range = IdNumber.new(start)..IdNumber.new(fin)
    end

    def sum_by_condition(&) = @range.select(&).sum(&:to_i)
  end

  class IdNumber
    include Comparable

    def initialize(digits) = @digits = digits

    def to_i = @digits.to_i
    def <=>(other) = to_i <=> other.to_i
    def succ = IdNumber.new((to_i + 1).to_s)

    def two_substrings?
      mid_idx = @digits.length / 2
      @digits[0...mid_idx] == @digits[mid_idx..]
    end

    def repeated_substrings?
      (@digits + @digits).index(@digits, 1) != @digits.length
    end
  end
end
