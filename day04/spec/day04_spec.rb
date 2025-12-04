require "spec_helper"

require_relative "../day04"

RSpec.describe Day04 do
  describe "::solve_one" do
    it "gives the correct answer for the sample input" do
      expect(described_class.solve_one("sample.txt")).to eq 13
    end
  end

  describe "::solve_two" do
    it "gives the correct answer for the sample input" do
      expect(described_class.solve_two("sample.txt")).to eq 43
    end
  end
end
