require "spec_helper"

require_relative "../day06"

RSpec.describe Day06 do
  describe "::solve_one" do
    it "gives the correct answer for the sample input" do
      expect(described_class.solve_one("sample.txt")).to eq 4_277_556
    end
  end

  describe "::solve_two" do
    it "gives the correct answer for the sample input" do
      expect(described_class.solve_two("sample.txt")).to eq 3_263_827
    end
  end
end
