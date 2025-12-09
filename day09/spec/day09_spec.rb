require "spec_helper"

require_relative "../day09"

RSpec.describe Day09 do
  describe "::solve_one" do
    it "gives the correct answer for the sample input" do
      expect(described_class.solve_one("sample.txt")).to eq 50
    end
  end

  describe "::solve_two" do
    it "gives the correct answer for the sample input" do
      expect(described_class.solve_two("sample.txt")).to eq 24
    end
  end
end
