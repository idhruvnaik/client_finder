require "rails_helper"

RSpec.describe ClientService::Filter do
  let(:client1) { double("Client", user_id: 2, name: "Alice", latitude: 18.5204, longitude: 73.8567) }
  let(:client2) { double("Client", user_id: 1, name: "Bob", latitude: 19.0760, longitude: 72.8777) }
  let(:clients) { [ client1, client2 ] }

  describe "#filter_by_distance" do
    before do
      allow(Distance::Calculator).to receive(:distance_from).with(client1.latitude, client1.longitude).and_return(150)
      allow(Distance::Calculator).to receive(:distance_from).with(client2.latitude, client2.longitude).and_return(10)
    end

    it "returns only clients within the given distance, sorted by user_id" do
      filter = ClientService::Filter.new(clients: clients, kilometers: 50)
      filter.filter_by_distance
      expect(filter.clients).to eq([ client2 ])
    end

    it "returns all clients within the distance when all qualify" do
      allow(Distance::Calculator).to receive(:distance_from).and_return(20)
      filter = ClientService::Filter.new(clients: clients, kilometers: 50)
      filter.filter_by_distance
      expect(filter.clients.map(&:user_id)).to eq([ 1, 2 ])
    end

    it "returns no clients if none are within the distance" do
      allow(Distance::Calculator).to receive(:distance_from).and_return(200)
      filter = ClientService::Filter.new(clients: clients, kilometers: 50)
      filter.filter_by_distance
      expect(filter.clients).to be_empty
    end

    it "raises and logs an error when Distance::Calculator fails" do
      allow(Distance::Calculator).to receive(:distance_from).and_raise(StandardError.new())
      allow(Rails.logger).to receive(:error)

      filter = ClientService::Filter.new(clients: clients, kilometers: 50)

      expect { filter.filter_by_distance }.to raise_error(StandardError)

      expect(Rails.logger).to have_received(:error).with(/Something went wrong ClientService::Filter#filter_by_distance/)
    end
  end
end
