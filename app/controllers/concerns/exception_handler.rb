module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      json_response({error: [{message: 'Document not found'}]}, :not_found)
    end

    rescue_from Mongoid::Errors::InvalidFind do |e|
      json_response({error: [{message: 'Invalid find'}]}, :unprocessable_entity)
    end
  end
end