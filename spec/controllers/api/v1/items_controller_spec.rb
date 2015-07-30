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

  context '#random' do
    it 'returns random item' do
      Item.create!(name: 'item1', description: 'description1', unit_price: 19, merchant_id: 18)
      Item.create!(name: 'item2', description: 'description2', unit_price: 29, merchant_id: 28)
      Item.create!(name: 'item3', description: 'description3', unit_price: 39, merchant_id: 38)
      Item.create!(name: 'item4', description: 'description4', unit_price: 49, merchant_id: 48)
      Item.create!(name: 'item5', description: 'description5', unit_price: 59, merchant_id: 58)
      Item.create!(name: 'item6', description: 'description6', unit_price: 69, merchant_id: 68)
      Item.create!(name: 'item7', description: 'description7', unit_price: 79, merchant_id: 78)
      Item.create!(name: 'item8', description: 'description8', unit_price: 89, merchant_id: 88)
      Item.create!(name: 'item9', description: 'description9', unit_price: 99, merchant_id: 98)
      get :random, format: :json

      expect(response).to have_http_status(:ok)
      item_response= JSON.parse(response.body)
      expect(item_response).not_to eq(Item.all.sample)
    end
  end

  context '#find' do
    it 'returns specific item' do
      item1 = Item.create!(name: 'item9', description: 'description9', unit_price: 99, merchant_id: 98)
      item2 = Item.create!(name: 'item3', description: 'description3', unit_price: 39, merchant_id: 38)
      get :find, name: item2.name

      expect(response).to have_http_status(:ok)
      item = JSON.parse(response.body)
      expect(item['name']).to eq('item3')
      expect(item['description']).to eq('description3')
      expect(item['unit_price']).to eq(39)
      expect(item['merchant_id']).to eq(38)
    end
  end

end
