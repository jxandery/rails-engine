require 'rails_helper'

RSpec.describe "/api/v1/invoice_items", type: :request do

  context 'GET /api/v1/invoice_items/:invoice_item_id/item' do
    it 'returns specific item' do
      item = Item.create!(name: 'item9', description: 'description9', unit_price: 99, merchant_id: 9)
      invoice_item1 = InvoiceItem.create!(invoice_id: 8, item_id: item.id, quantity: 119, unit_price: 17)
      get "/api/v1/invoice_items/#{invoice_item1.id}/item", invoice_id: 19, format: :json

      expect(response).to have_http_status(:ok)
      item_response = JSON.parse(response.body)
      expect(item_response['name']).to eq('item9')
      expect(item_response['description']).to eq('description9')
      expect(item_response['unit_price']).to eq(99)
      expect(item_response['merchant_id']).to eq(9)
    end
  end
end
