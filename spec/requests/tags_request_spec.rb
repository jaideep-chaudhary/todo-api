require 'rails_helper'

RSpec.describe 'Tags', type: :request do
  # initialize test data
  let!(:tags) { create_list(:tag, 5) }
  let(:tag_id) { tags.first.id.to_s }

  # Test suite for GET /tags
  describe 'GET /tags' do
    # make HTTP get request before each example
    before { get '/tags' }

    it 'returns tags' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /tags/:id
  describe 'GET /tags/:id' do
    before { get "/tags/#{tag_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['tag']['_id']['$oid']).to eq(tag_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:tag_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Document not found for class Tag with attributes/)
      end
    end
  end

  # Test suite for POST /tags
  describe 'POST /tags' do
    # valid payload
    let(:valid_attributes) { { title: 'Important' } }

    context 'when the request is valid' do
      before { post '/tags', valid_attributes }

      it 'returns status code 201' do
        expect(response.body['title'].eql?('Important'))
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/tags', name: 'Foobar' }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/\nmessage:\n  Validation of Tag failed.\nsummary:\n/)
      end
    end
  end

  # Test suite for PUT /tags/:id
  describe 'PUT /tags/:id' do
    let(:valid_attributes) { { title: 'In a meeting' } }

    context 'when the record exists' do
      before { put "/tags/#{tag_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /tags/:id
  describe 'DELETE /tags/:id' do

    before { delete "/tags/#{tag_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
