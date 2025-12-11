require "spec_helper"

require_relative "../day11"

RSpec.describe Day11 do
  describe "::solve_one" do
    it "gives the correct answer for the sample input" do
      expect(described_class.solve_one("sample.txt")).to eq 5
    end
  end

  describe "::solve_two" do
    it "gives the correct answer for the sample input" do
      expect(described_class.solve_two("sample2.txt")).to eq 2
    end
  end
end
