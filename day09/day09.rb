module Day09
  module_function

  def solve_one(...) = parse(...).largest_rect

  def solve_two(...) = parse(...).largest_rect_inside_tiles

  def parse(input_filename)
    File.readlines(input_filename, chomp: true).then { TileFloor.from_lines it }
  end

  class TileFloor
    def self.from_lines(lines) = new(lines.map { it.split(",").map(&:to_i) })

    Rectangle = Data.define(:x1, :y1, :x2, :y2) do
      def self.to_proc = proc { |a, b| Rectangle[*a, *b] }
      def area = ((x1 - x2).abs + 1) * ((y1 - y2).abs + 1)
      def sorted_points = [x1, x2].sort + [y1, y2].sort
      def <=>(other) = area <=> other.area

      def intersects?(other)
        sx1, sx2, sy1, sy2 = sorted_points
        ox1, ox2, oy1, oy2 = other.sorted_points

        sx1 < ox2 && sx2 > ox1 && sy1 < oy2 && sy2 >= oy1
      end
    end

    def initialize(red_tiles) = @red_tiles = red_tiles

    def largest_rect = rectangles_by_area.first.area

    def largest_rect_inside_tiles
      rectangles_by_area
        .find { |rect| edges.none? { |e| rect.intersects?(e) } }
        .area
    end

    def rectangles_by_area = @red_tiles.combination(2).map(&Rectangle).sort.reverse!

    def edges
      @edges ||= [*@red_tiles, @red_tiles.last].each_cons(2).map(&Rectangle).sort.reverse!
    end
  end
end
