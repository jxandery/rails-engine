require 'rails_helper'

RSpec.describe "/api/v1/merchants", type: :request do

  context 'GET /api/v1/merchants/:merchant_id/favorite_customers' do
    it 'returns favorite_customer' do
      customer1 = Customer.create!(first_name: 'strawberry', last_name: 'red')
      customer2 = Customer.create!(first_name: 'blueberry', last_name: 'pancakes')
      merchant = Merchant.create!(name: 'Jorge')
      invoice1 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer2.id, merchant_id: merchant.id, status: "success")
      invoice3 = Invoice.create!(customer_id: customer2.id, merchant_id: merchant.id, status: "success")
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '78', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '88', result: 'success')
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '78', result: 'success')
      get "/api/v1/merchants/#{merchant.id}/favorite_customer", format: :json

      expect(response).to have_http_status(:ok)
      favorite_customer_response = JSON.parse(response.body)
      expect(favorite_customer_response.class).to eq(Hash)
      expect(favorite_customer_response['first_name']).to eq('blueberry')
      expect(favorite_customer_response['last_name']).to eq('pancakes')
    end
  end

end
