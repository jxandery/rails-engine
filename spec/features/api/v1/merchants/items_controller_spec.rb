require 'rails_helper'

RSpec.describe "/api/v1/merchants", type: :request do

  context 'GET /api/v1/merchants/:merchant_id/items' do
    it 'returns items' do
      merchant = Merchant.create!(name: 'Auste8')
      item1 = Item.create!(name: 'item9', description: 'description9', unit_price: 99, merchant_id: merchant.id)
      item2 = Item.create!(name: 'item3', description: 'description9', unit_price: 39, merchant_id: merchant.id)
      get "/api/v1/merchants/#{merchant.id}/items", format: :json

      expect(response).to have_http_status(:ok)
      items_response = JSON.parse(response.body)
      expect(items_response.count).to eq(2)
      expect(items_response.first['merchant_id']).to eq(merchant.id)
      expect(items_response.second['merchant_id']).to eq(merchant.id)
    end
  end
end
