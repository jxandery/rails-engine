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

  context '#random' do
    it 'returns random customer' do
      Merchant.create!(name: 'Auste1')
      Merchant.create!(name: 'Auste2')
      Merchant.create!(name: 'Auste3')
      Merchant.create!(name: 'Auste4')
      Merchant.create!(name: 'Auste5')
      Merchant.create!(name: 'Auste6')
      Merchant.create!(name: 'Auste7')
      Merchant.create!(name: 'Auste8')
      Merchant.create!(name: 'Auste9')
      get :random, format: :json

      expect(response).to have_http_status(:ok)
      merchant_response = JSON.parse(response.body)
      expect(merchant_response).not_to eq(Merchant.all.sample)
    end
  end

end
