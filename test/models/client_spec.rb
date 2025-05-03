require "rails_helper"

RSpec.describe Client, type: :model do
  describe "Field validations" do
    before(:each) do
      @client = Client.new(user_id: 1, name: "Amaha", latitude: -19.20, longitude: 17.20)
    end

    it "is valid with all attributes" do
      expect(@client).to be_valid
    end

    it "is invalid without user_id" do
      @client.user_id = nil
      expect(@client).not_to be_valid
      expect(@client.errors[:user_id]).to include("can't be blank")
    end

    it "is invalid without name" do
      @client.name = nil
      expect(@client).not_to be_valid
      expect(@client.errors[:name]).to include("can't be blank")
    end

    it "is invalid without latitude" do
      @client.latitude = nil
      expect(@client).not_to be_valid
      expect(@client.errors[:latitude]).to include("can't be blank")
    end

    it "is invalid without longitude" do
      @client.longitude = nil
      expect(@client).not_to be_valid
      expect(@client.errors[:longitude]).to include("can't be blank")
    end

    it "is invalid if latitude is not a number" do
      @client.latitude = "abc"
      expect(@client).not_to be_valid
      expect(@client.errors[:latitude]).to include("is not a number")
    end

    it "is invalid if user_id is not an integer" do
      @client.user_id = "abc"
      expect(@client).not_to be_valid
      expect(@client.errors[:user_id]).to include("is not a number")
    end
  end
end
