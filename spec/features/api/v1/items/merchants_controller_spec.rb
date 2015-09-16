require 'rails_helper'

RSpec.describe "/api/v1/items", type: :request do

  context 'GET /api/v1/items/:item_id/merchant' do
    it 'returns merchant' do
      merchant = Merchant.create!(name: 'Austen')
      item = Item.create!(name: 'item9', description: 'description9', unit_price: 99, merchant_id: merchant.id)
      get "/api/v1/items/#{item.id}/merchant", format: :json

      expect(response).to have_http_status(:ok)
      merchant_response = JSON.parse(response.body)
      expect(merchant_response.class).to eq(Hash)
      expect(merchant_response['name']).to eq('Austen')
    end
  end
end
