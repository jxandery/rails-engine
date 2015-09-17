require 'rails_helper'

RSpec.describe "/api/v1/merchants", type: :request do

  context 'GET /api/v1/merchants/:merchant_id/customers_with_pending_invoices' do
    it 'returns customers with pending invoices' do
      customer1 = Customer.create!(first_name: 'strawberry', last_name: 'red')
      customer2 = Customer.create!(first_name: 'blueberry', last_name: 'pancakes')
      merchant = Merchant.create!(name: 'Jorge')
      invoice1 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer2.id, merchant_id: merchant.id, status: "success")
      invoice3 = Invoice.create!(customer_id: customer2.id, merchant_id: merchant.id, status: "success")
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '78', result: 'failed')
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '88', result: 'failed')
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '78', result: 'failed')
      transaction4 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '78', result: 'success')
      get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices", format: :json

      expect(response).to have_http_status(:ok)
      invoices_response = JSON.parse(response.body)
      expect(invoices_response.count).to eq(2)
      expect(invoices_response.first['first_name']).to eq('strawberry')
      expect(invoices_response.first['last_name']).to eq('red')
      expect(invoices_response.second['first_name']).to eq('blueberry')
      expect(invoices_response.second['last_name']).to eq('pancakes')
    end
  end

end
