require 'rails_helper'

RSpec.describe "/api/v1/merchants", type: :request do

  context 'GET /api/v1/merchants' do
    it 'returns all the merchants' do
      Merchant.create!(name: 'Austen')
      get "/api/v1/merchants", format: :json

      expect(response).to have_http_status(:ok)
      merchants = JSON.parse(response.body)
      expect(merchants.count).to eq(1)

      merchant = merchants.first
      expect(merchant['name']).to eq('Austen')
    end
  end

  context 'GET /api/v1/merchants/:id' do
    it 'returns individual merchant' do
      merchant = Merchant.create!(name: 'Austen')
      get "/api/v1/merchants/#{merchant.id}", format: :json

      expect(response).to have_http_status(:ok)
      merchant_response = JSON.parse(response.body)
      expect(merchant['name']).to eq('Austen')
    end
  end

  context 'GET /api/v1/merchants/random' do
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
      get "/api/v1/merchants/random", format: :json

      expect(response).to have_http_status(:ok)
      merchant_response = JSON.parse(response.body)
      expect(merchant_response).not_to eq(Merchant.all.sample)
    end
  end

  context 'GET /api/v1/merchants/find' do
    it 'returns specific merchant' do
      Merchant.create!(name: 'Auste8')
      Merchant.create!(name: 'Auste9')
      get "/api/v1/merchants/find", name: 'Auste9', format: :json

      expect(response).to have_http_status(:ok)
      merchant_response = JSON.parse(response.body)
      expect(merchant_response['name']).to eq('Auste9')
    end
  end

  context 'GET /api/v1/merchants/find_all' do
    it 'returns all merchants' do
      Merchant.create!(name: 'Auste8')
      Merchant.create!(name: 'Auste9')
      get "/api/v1/merchants/find_all", first_name: 'billy', format: :json

      expect(response).to have_http_status(:ok)
      merchant_response = JSON.parse(response.body)
      expect(merchant_response.second['name']).to eq('Auste9')
      expect(merchant_response.count).to eq(2)
    end
  end
end
