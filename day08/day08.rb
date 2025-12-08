module Day08
  module_function

  def solve_one(input_filename)
    is_sample = input_filename.include?("sample")
    parse(input_filename)
      .tap { it.build_network(is_sample ? 10 : 1000) }
      .largest_circuits_product
  end

  def solve_two(...) = parse(...).tap(&:build_network).final_connection_product

  def parse(input_filename)
    File.readlines(input_filename, chomp: true)
        .map { |line| Coords[*line.split(",").map(&:to_i)] }
        .then { CircuitField.new it }
  end

  Coords = Data.define(:x, :y, :z) do
    def dist(other)
      Math.sqrt([x - other.x, y - other.y, z - other.z].sum(&:abs2))
    end
  end

  class CircuitField
    def initialize(junction_boxes)
      @junction_boxes = junction_boxes
      @network = {}
      @incrementing_id = 0
      @final_connections = []
    end

    def build_network(num = junctions_by_dist.length)
      junctions_by_dist.first(num).each do |pair|
        pair.map { find_or_init_network it } => [[id_a, set_a], [id_b, set_b]]

        @network[id_a] = set_a + set_b
        @network.delete(id_b) if id_b != id_a

        @final_connections.push(*pair) and break if junctions_on_one_network?

        @incrementing_id += 1
      end
    end

    def largest_circuits_product = @network.values.map(&:length).max(3).reduce(:*)
    def final_connection_product = @final_connections.map(&:x).reduce(:*)

    private

    def junctions_on_one_network?
      @network.first in _id, junctions or return false
      junctions.length == @junction_boxes.length
    end

    def find_or_init_network(point)
      @network.find { |_id, set| set.include?(point) } || [@incrementing_id, Set.new([point])]
    end

    def junctions_by_dist
      @junctions_by_dist ||= @junction_boxes.combination(2).sort_by { |a, b| a.dist(b) }
    end
  end
end
