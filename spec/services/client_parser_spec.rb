require "rails_helper"

RSpec.describe ClientService::Parser, type: :service do
  describe "#parse" do
    let(:valid_file) {
      StringIO.new([
        { user_id: 1, name: "John Doe", latitude: 19.0760, longitude: 72.8777 }.to_json,
        { user_id: 2, name: "Jane Smith", latitude: 28.7041, longitude: 77.1025 }.to_json,
      ].join("\n"))
    }

    let(:empty_file) { StringIO.new("") }
    let(:invalid_file) { StringIO.new('invalid json\n') }

    context "when the file is valid" do
      it "parses the file and creates client records" do
        parser = ClientService::Parser.new(file: valid_file)
        parser.parse

        expect(parser.clients.count).to eq(2)
        expect(parser.clients.first.user_id).to eq(1)
        expect(parser.clients.first.name).to eq("John Doe")
        expect(parser.clients.first.latitude).to eq(19.0760)
        expect(parser.clients.first.longitude).to eq(72.8777)
      end
    end

    context "when the file is empty" do
      it "does not create any client records" do
        parser = ClientService::Parser.new(file: empty_file)
        parser.parse

        expect(parser.clients.count).to eq(0)
      end
    end

    context "when the file contains invalid JSON" do
      it "raises an error and logs it" do
        allow(Rails.logger).to receive(:error)
        parser = ClientService::Parser.new(file: invalid_file)

        expect { parser.parse }.to raise_error(JSON::ParserError)
        expect(Rails.logger).to have_received(:error).with(/Something went wrong Client::Parser#parse/)
      end
    end
  end
end
