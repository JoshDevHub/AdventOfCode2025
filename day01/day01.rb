module Day01
  module_function

  def parse(input_filename) = File.readlines(input_filename, chomp: true)

  def solve_one(input_filename)
    parse(input_filename).then { run_rotations it }.count(&:zero?)
  end

  def solve_two(input_filename)
    parse(input_filename).then { run_rotations it }.sum(&:revolutions)
  end

  def run_rotations(instructions)
    rotations = instructions.map { Rotation.new(it[0], it[1..].to_i) }

    dial_position = 50
    rotations.each do |rotation|
      rotation.execute!(dial_position)
      dial_position = rotation.resting_position
    end

    rotations
  end

  class Rotation
    attr_reader :revolutions, :resting_position

    def initialize(dir, number)
      @dir = dir
      @number = number
      @revolutions = 0
      @resting_position = nil
    end

    def execute!(dial_value)
      @number.times do
        dial_value += step
        dial_value %= 100

        @revolutions += 1 if dial_value.zero?
      end

      @resting_position = dial_value
    end

    def zero? = @resting_position.zero?

    private

    def step = @dir == "L" ? -1 : 1
  end
end
