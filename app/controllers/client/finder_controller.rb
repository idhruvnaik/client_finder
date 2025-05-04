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

      render_success(filter.clients, "Filtered clients", :ok) and return
    rescue => error
      Rails.logger.warn("Something went wrong Client#within_n_km #{error.message}")
      render_failure({}, "Something went wrong !!", :internal_server_error) and return
    end
  end
end
