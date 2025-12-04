module Day03
  module_function

  def solve_one(...) = parse(...).sum(&:two_battery_max_joltage)

  def solve_two(...) = parse(...).sum(&:twelve_battery_max_joltage)

  def parse(input_filename) = File.readlines(input_filename, chomp: true).map(&Bank)

  class Bank
    def self.to_proc = proc { new it.chars.map(&:to_i) }

    def initialize(digits) = @digits = digits

    def two_battery_max_joltage = max_joltage(2)
    def twelve_battery_max_joltage = max_joltage(12)

    private

    def max_joltage(size)
      accumulate_to_stack do |(digit, i), stack|
        stack.pop while !stack.empty? &&
                        stack.length > i - @digits.length + size &&
                        digit > stack.last
        stack << digit if stack.length < size
      end
    end

    def accumulate_to_stack(&)
      stack = []
      @digits.each_with_index.each_with_object(stack, &)
      stack.join.to_i
    end
  end
end
