class Client::FinderController < ApplicationController
  def within_n_km
    return unless validate_required_params(:file, :kilometers)

    begin
      file = params[:file]
      kilometers = params[:kilometers]

      parser = ClientService::Parser.new(file: file)
      parser.parse

      filter = ClientService::Filter.new(clients: parser.clients, kilometers: kilometers)
      filter.filter_by_distance

      @clients = filter.clients

      render_json_builder(path: :within_n_km)
    rescue JSON::ParserError => error
      Rails.logger.error("Something went wrong Client#within_n_km #{error.message}")
      render_failure({}, "Invalid file format", :internal_server_error) and return
    rescue => error
      Rails.logger.error("Something went wrong Client#within_n_km #{error.message}")
      render_failure({}, error.message, :internal_server_error) and return
    end
  end
end
