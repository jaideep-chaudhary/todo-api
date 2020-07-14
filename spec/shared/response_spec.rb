require 'rails_helper'

RSpec.shared_examples 'Response' do |including_controller|
  let(:instance) { including_controller.new }

  it 'should respond to #json_response' do
    expect(instance).to respond_to(:json_response)
  end

  it 'should respond #respond_with_errors' do
    expect(instance).to respond_to(:respond_with_errors)
  end

  context '#respond_with_errors' do
    it 'returns :unprocessable_entity status' do
      model = double(:model)
      errors = double(:errors, messages: {})
      allow(model).to receive(:errors).and_return(errors)
      response = instance.respond_with_errors(model)
      expect(response[:status]).to eq :unprocessable_entity
    end
  end

  context '#json_response' do
    it 'returns JSON with default :ok status' do
      model = double(:model)
      response = instance.json_response(model)
      expect(response[:status]).to eq :ok
    end

    it 'returns JSON with the specified status' do
      model = double(:model)
      response = instance.json_response(model, :partial_content)
      expect(response[:status]).to eq :partial_content
    end
  end
end