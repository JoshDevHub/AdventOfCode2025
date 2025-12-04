require "spec_helper"

require_relative "../day03"

RSpec.describe Day03 do
  describe "::solve_one" do
    it "gives the correct answer for the sample input" do
      expect(described_class.solve_one("sample.txt")).to eq 357
    end
  end

  describe "::solve_two" do
    it "gives the correct answer for the sample input" do
      expect(described_class.solve_two("sample.txt")).to eq 3_121_910_778_619
    end
  end
end
