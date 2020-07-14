require 'rails_helper'
require 'shared/response_spec'

class ResponseController < ApplicationController

  def render(*args)
    args.first
  end
end

RSpec.describe ResponseController, type: :controller do
  it_should_behave_like 'Response', ResponseController
end