class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery unless: -> { request.format.json? }
  skip_before_action :verify_authenticity_token
  include Response
  include ExceptionHandler
end