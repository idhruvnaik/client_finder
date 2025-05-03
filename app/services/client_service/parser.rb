module ClientService
  class Parser
    attr_reader :clients

    def initialize(file:)
      @file = file
      @clients = []
    end

    def parse
      begin
        @file.read.each_line do |line|
          data = JSON.parse(line, symbolize_names: true)
          @clients << Client.new(user_id: data[:user_id], name: data[:name], latitude: data[:latitude], longitude: data[:longitude])
        end
      rescue JSON::ParserError => error
        Rails.logger.error("Something went wrong Client::Parser#parse - JSON::ParserError #{error.message}")
        raise error
      rescue => error
        Rails.logger.error("Something went wrong Client::Parser#parse #{error.message}")
        raise error
      end
    end
  end
end
