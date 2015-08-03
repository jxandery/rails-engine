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

  context '#revenue' do
    it 'returns revenue' do
      merchant = Merchant.create!(name: 'Auste8')
      customer1 = Customer.create!(first_name: 'strawberry', last_name: 'red')
      customer2 = Customer.create!(first_name: 'cherry', last_name: 'black')
      invoice1 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant.id, status: "success")
      invoice3 = Invoice.create!(customer_id: customer2.id, merchant_id: merchant.id, status: "success")
      item1 = Item.create!(name: 'item9', description: 'description9', unit_price: 10, merchant_id: merchant.id)
      item2 = Item.create!(name: 'item3', description: 'description9', unit_price: 30, merchant_id: merchant.id)
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 1, unit_price: 10)
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 10)
      InvoiceItem.create!(invoice_id: invoice2.id, item_id: item2.id, quantity: 3, unit_price: 30)
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '9807', credit_card_expiration_date: '04041978', result: 'pending')
      get :revenue, merchant_id: merchant.id

      expect(response).to have_http_status(:ok)
      revenue_response = JSON.parse(response.body)
      expect(revenue_response.class).to eq(Hash)
      expect(revenue_response["revenue"].to_i).to eq(120)
    end
  end


  context '#favorite_customer' do
    it 'returns favorite_customer' do
      customer1 = Customer.create!(first_name: 'strawberry', last_name: 'red')
      customer2 = Customer.create!(first_name: 'blueberry', last_name: 'pancakes')
      merchant = Merchant.create!(name: 'Jorge')
      invoice1 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer2.id, merchant_id: merchant.id, status: "success")
      invoice3 = Invoice.create!(customer_id: customer2.id, merchant_id: merchant.id, status: "success")
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '88', credit_card_expiration_date: '08081978', result: 'success')
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      get :favorite_customer, merchant_id: merchant.id

      expect(response).to have_http_status(:ok)
      favorite_customer_response = JSON.parse(response.body)
      expect(favorite_customer_response.class).to eq(Hash)
      expect(favorite_customer_response['first_name']).to eq('blueberry')
      expect(favorite_customer_response['last_name']).to eq('pancakes')
    end
  end
end
