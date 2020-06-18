require 'rails_helper'

RSpec.describe 'Items', type: :request do
  # initialize test data
  let!(:items) { create_list(:item, 5) }
  let(:item_id) { items.first.id.to_s }

  # Test suite for GET /items
  describe 'GET /items' do
    # make HTTP get request before each example
    before { get '/items' }

    it 'returns items' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /items/:id
  describe 'GET /items/:id' do
    before { get "/items/#{item_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['item']['_id']['$oid']).to eq(item_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:item_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Document not found for class Item with attributes/)
      end
    end
  end

  # Test suite for POST /items
  describe 'POST /items' do
    # valid payload
    let(:valid_attributes) { { name: 'Test', status: 'Important' } }

    context 'when the request is valid' do
      before { post '/items', valid_attributes }

      it 'returns status code 201' do
        expect(response.body['name'].eql?('Test'))
        expect(response.body['status'].eql?('Important'))
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/items', status: 'Foobar' }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/\nmessage:\n  Validation of Item failed.\nsummary:\n/)
      end
    end
  end

  # Test suite for PUT /items/:id
  describe 'PUT /items/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/items/#{item_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /items/:id
  describe 'DELETE /items/:id' do
    let(:delete_status) { { deleted: true } }

    before { delete "/items/#{item_id}", delete_status }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  # Test suite for GET /get_items
  describe 'GET /get_items' do
    let(:tag_title) { { title: 'Important' } }

    before { get '/get_items', tag_title }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
