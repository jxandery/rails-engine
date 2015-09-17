require 'rails_helper'

RSpec.describe "/api/v1/customers", type: :request do

  context 'GET /api/v1/customers/:customer_id/favorite_merchant' do
    it 'returns favorite_merchant' do
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      merchant1 = Merchant.create!(name: 'Jorge')
      merchant2 = Merchant.create!(name: 'Austen')
      invoice1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant1.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer.id, merchant_id: merchant1.id, status: "success")
      invoice3 = Invoice.create!(customer_id: customer.id, merchant_id: merchant2.id, status: "success")
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '78', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '88', result: 'success')
      transaction3 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '78', result: 'success')
      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      expect(response).to have_http_status(:ok)
      favorite_merchant_response = JSON.parse(response.body)
      expect(favorite_merchant_response.class).to eq(Hash)
      expect(favorite_merchant_response['name']).to eq('Jorge')
    end
  end
end
