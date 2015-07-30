require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  context '#index' do
    it 'returns all the merchants' do
      Merchant.create!(name: 'Austen')
      get :index, format: :json

      expect(response).to have_http_status(:ok)
      merchants = JSON.parse(response.body)
      expect(merchants.count).to eq(1)

      merchant = merchants.first
      expect(merchant['name']).to eq('Austen')
    end
  end

  context '#show' do
    it 'returns individual merchant' do
      merchant = Merchant.create!(name: 'Austen')
      get :show, id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)
      merchant_response = JSON.parse(response.body)
      expect(merchant['name']).to eq('Austen')
    end
  end
end
