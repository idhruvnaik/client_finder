module Request
  module ResponseHandlers
    extend ActiveSupport::Concern

    def render_success(data = {}, message = "Success !!", status = :ok)
      render json: { data: data, message: message }, status: status
    end

    def render_json_builder(path:, status: :ok)
      render path, status: status and return
    end

    def render_failure(data = {}, message = "Failure !!", status = :internal_server_error)
      render json: { data: data, message: message }, status: status
    end
  end
end
