require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  context '#index' do
    it 'returns all the items' do
      Item.create!(name: 'Austen', description: 'hunger academy alum', unit_price: 99, merchant_id: 88)
      get :index, format: :json

      expect(response).to have_http_status(:ok)
      items = JSON.parse(response.body)
      expect(items.count).to eq(1)

      item = items.first
      expect(item['name']).to eq('Austen')
      expect(item['description']).to eq('hunger academy alum')
      expect(item['unit_price']).to eq(99)
      expect(item['merchant_id']).to eq(88)
    end
  end

  context '#show' do
    it 'returns individual item' do
      item = Item.create!(name: 'Austen', description: 'hunger academy alum', unit_price: 99, merchant_id: 88)
      get :show, id: item.id, format: :json

      expect(response).to have_http_status(:ok)
      item_response = JSON.parse(response.body)
      expect(item['name']).to eq('Austen')
      expect(item['description']).to eq('hunger academy alum')
      expect(item['unit_price']).to eq(99)
      expect(item['merchant_id']).to eq(88)
    end
  end
end
