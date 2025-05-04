require "rails_helper"

RSpec.describe Client::FinderController, type: :request do
  describe "post #client_finder_within_n_km" do
    let(:file) { fixture_file_upload("spec/fixtures/clients.jsonl", "application/json") }

    before do
      allow(Distance::Calculator).to receive(:distance_from).and_return(10)
    end

    it "returns success with filtered clients" do
      post "/client/finder/within_n_km", params: { file: file, kilometers: 50 }

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["data"].size).to eq(2)
    end

    it "returns failure if required params are missing" do
      post "/client/finder/within_n_km", params: { kilometers: 50 }

      expect(response).to have_http_status(:bad_request)
    end

    it "returns internal server error on parse failure" do
      bad_file = Tempfile.new("bad")
      bad_file.write("{ invalid json }")
      bad_file.rewind
      post "/client/finder/within_n_km", params: { file: Rack::Test::UploadedFile.new(bad_file.path), kilometers: 50 }

      expect(response).to have_http_status(:internal_server_error)
      bad_file.close
      bad_file.unlink
    end
  end
end
