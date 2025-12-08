module Day07
  module_function

  def solve_one(...) = parse(...).split_count

  def solve_two(...) = parse(...).beams_total

  def parse(input_filename)
    File.readlines(input_filename, chomp: true)
        .map(&:chars)
        .then { Manifold.new it }
        .tap(&:generate_beams)
  end

  class Manifold
    attr_reader :split_count

    def initialize(data)
      @data = data
      @beams = Hash.new(0)
      @split_count = 0
    end

    SPLITTER_CHAR = "^".freeze

    def beams_total = @beams.values.sum

    def generate_beams
      start_idx = @data.first.find_index("S")
      @beams[start_idx] = 1

      each do |line|
        @split_count +=
          line.each_with_index
              .select { |char, col_idx| char == SPLITTER_CHAR && beams_at?(col_idx) }
              .each { |_, col_idx| split_beams(col_idx) }
              .length
      end
    end

    private

    def each(...) = @data.each(...)

    def beams_at?(idx) = @beams[idx].positive?

    def split_beams(idx)
      @beams[idx - 1] += @beams[idx]
      @beams[idx + 1] += @beams[idx]
      @beams[idx] = 0
    end
  end
end
