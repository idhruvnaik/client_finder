require "rails_helper"

RSpec.describe Distance::Calculator, type: :lib do
  describe ".distance_from" do
    it "calculates the correct distance between two places" do
      distance = Distance::Calculator.distance_from(18.5204, 73.8567)
      expect(distance).to eq(130.49)
    end

    it "calculates the distance as a float rounded to two decimal places" do
      distance = Distance::Calculator.distance_from(18.5204, 73.8567)

      expect(distance).to be_a(Float)
      expect(distance).to eq(distance.round(2))
    end

    it "returns 0 for the same lat & long" do
      distance = Distance::Calculator.distance_from(OFFICE.dig(:mumbai, :lat), OFFICE.dig(:mumbai, :lon))

      expect(distance).to eq(0.0)
    end
  end
end
