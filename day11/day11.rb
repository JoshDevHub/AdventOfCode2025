module Day11
  module_function

  def solve_one(...) = parse(...).dfs(%w[you out])

  def solve_two(...)
    rack = parse(...)
    [%w[svr fft], %w[fft dac], %w[dac out]].map { rack.dfs it }.reduce(:*)
  end

  def parse(input_filename)
    File.readlines(input_filename, chomp: true).then { Rack.from_lines it }
  end

  class Rack
    def self.from_lines(lines)
      graph = lines.to_h do |line|
        device, *adjs = line.tr(":", "").split
        [device, adjs]
      end

      graph["out"] = []
      new(graph)
    end

    def initialize(graph) = @graph = graph

    def dfs((curr, target), memo = {})
      return 1 if curr == target

      memo[curr] ||= @graph[curr].sum { |adj| dfs([adj, target], memo) }
    end
  end
end
