module ClientService
  class Filter
    attr_reader :clients

    def initialize(clients:, kilometers:)
      @clients = clients
      @kilometers = kilometers
    end

    def filter_by_distance
      begin
        nearby_clients = @clients.select do |client|
          client_distance = Distance::Calculator.distance_from(client.latitude, client.longitude)
          client_distance <= @kilometers.to_f
        end

        @clients = nearby_clients.sort_by(&:user_id)
      rescue => error
        Rails.logger.error("Something went wrong ClientService::Filter#filter_by_distance => #{error.message}")
        raise error
      end
    end
  end
end
