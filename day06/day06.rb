module Day06
  module_function

  def solve_one(...) = parse(...).map(&:split).transpose.sum(&Equation)

  def solve_two(...)
    parse(...)
      .map(&:chars)
      .transpose
      .map(&:join)
      .reverse
      .chunk { |str| !str.strip.empty? }
      .filter_map { |(res, eq_data)| [*eq_data, eq_data[-1][-1]] if res }
      .sum(&Equation)
  end

  def parse(input_filename) = File.readlines(input_filename)

  class Equation
    def self.to_proc = proc { Equation.new(it).result }

    def initialize(equation_data)
      @op = equation_data.last.strip.to_sym
      @numbers = equation_data[...-1].map(&:to_i)
    end

    def result = @numbers.reduce(@op)
  end
end
