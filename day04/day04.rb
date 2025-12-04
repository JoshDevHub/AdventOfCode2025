module Day04
  module_function

  def solve_one(...)
    graph = parse(...)
    graph.mark_for_removal
    graph.count_marked
  end

  def solve_two(...)
    graph = parse(...)
    graph.remove_until_inaccessible
    graph.removed_total
  end

  def parse(input_filename)
    grid = File.readlines(input_filename, chomp: true).map(&:chars)
    PaperGrid.from_array(grid)
  end

  class PaperGrid
    def self.from_array(array)
      grid = {}

      array.each_with_index do |row, row_idx|
        row.each_with_index do |char, col_idx|
          grid[Position.new(row: row_idx, col: col_idx)] = char
        end
      end

      new(grid)
    end

    Position = Data.define(:row, :col) do
      def +(other) = Position[row + other.row, col + other.col]
      def adjs_from_list(list) = list.map { it + self }
    end

    attr_reader :removed_total

    def initialize(grid)
      @grid = grid
      @marked_for_removal = []
      @removed_total = 0
    end

    PAPER_CHAR = "@".freeze
    DIRS = [
      [0, 1], [1, 0], [0, -1], [-1, 0],
      [1, 1], [1, -1], [-1, 1], [-1, -1]
    ].map { Position[*it] }.freeze

    def count_marked = @marked_for_removal.length

    def remove_until_inaccessible
      mark_for_removal

      until @marked_for_removal.empty?
        remove
        mark_for_removal
      end
    end

    def remove
      @removed_total += @marked_for_removal.length

      @marked_for_removal.each { @grid[it] = "x" }
      @marked_for_removal.clear
    end

    def mark_for_removal
      @grid.each do |pos, char|
        next unless char == PAPER_CHAR

        adjs = adjs_for(pos)
        @marked_for_removal << pos if adjs.count(PAPER_CHAR) < 4
      end
    end

    def adjs_for(pos) = pos.adjs_from_list(DIRS).filter_map(&@grid)
  end
end
