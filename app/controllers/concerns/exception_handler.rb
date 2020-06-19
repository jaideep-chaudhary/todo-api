module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from Mongoid::Errors::InvalidFind do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end
end