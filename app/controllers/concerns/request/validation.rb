module Request
  module Validation
    extend ActiveSupport::Concern

    def validate_required_params(*keys)
      missing_keys = keys.select { |key| !params.key?(key.to_s) }

      if missing_keys.present?
        render json: { message: "Missing parameters: #{missing_keys.join(", ")}" }, status: :bad_request
        return false
      end

      true
    end
  end
end
