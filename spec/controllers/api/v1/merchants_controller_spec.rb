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

  context '#find' do
    it 'returns specific merchant' do
      Merchant.create!(name: 'Auste8')
      Merchant.create!(name: 'Auste9')
      get :find, name: 'Auste9', format: :json

      expect(response).to have_http_status(:ok)
      merchant_response = JSON.parse(response.body)
      expect(merchant_response['name']).to eq('Auste9')
    end
  end

  context '#find_all' do
    it 'returns all merchants' do
      Merchant.create!(name: 'Auste8')
      Merchant.create!(name: 'Auste9')
      get :find_all, first_name: 'billy'

      expect(response).to have_http_status(:ok)
      merchant_response = JSON.parse(response.body)
      expect(merchant_response.second['name']).to eq('Auste9')
      expect(merchant_response.count).to eq(2)
    end
  end

  context '#invoices' do
    it 'returns invoices' do
      merchant = Merchant.create!(name: 'Auste8')
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      get :invoices, merchant_id: merchant.id

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
      expect(invoice_response.first['merchant_id']).to eq(merchant.id)
      expect(invoice_response.second['merchant_id']).to eq(merchant.id)
    end
  end

  context '#items' do
    it 'returns items' do
      merchant = Merchant.create!(name: 'Auste8')
      item1 = Item.create!(name: 'item9', description: 'description9', unit_price: 99, merchant_id: merchant.id)
      item2 = Item.create!(name: 'item3', description: 'description9', unit_price: 39, merchant_id: merchant.id)
      get :items, merchant_id: merchant.id

      expect(response).to have_http_status(:ok)
      items_response = JSON.parse(response.body)
      expect(items_response.count).to eq(2)
      expect(items_response.first['merchant_id']).to eq(merchant.id)
      expect(items_response.second['merchant_id']).to eq(merchant.id)
    end
  end

end
