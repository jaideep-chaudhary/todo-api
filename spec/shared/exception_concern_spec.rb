require 'rails_helper'

RSpec.shared_examples 'ExceptionConcern' do |including_controller|
  let(:instance) { including_controller.new }
  let(:id) { 0 }

  it 'raises DocumentNotFound exception' do
    expect { instance.show(id) }.to raise_error(Mongoid::Errors::DocumentNotFound)
  end

  it 'raises InvalidFind exception' do
    expect { instance.find_item(nil) }.to raise_error(Mongoid::Errors::InvalidFind)
  end

end