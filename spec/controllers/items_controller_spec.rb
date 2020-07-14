require 'rails_helper'
require 'shared/exception_concern_spec'

class ItemsController < ApplicationController
  include ExceptionHandler

  def show(id)
    Item.find_by(id: id)
  end

  def find_item(id)
    Item.find(id)
  end
end

RSpec.describe ItemsController, type: :controller do
  it_behaves_like 'ExceptionConcern', ItemsController
end