require 'rails_helper'

RSpec.describe "/api/v1/merchants", type: :request do

  context 'GET /api/v1/merchants/:merchant_id/invoices' do
    it 'returns invoices' do
      merchant = Merchant.create!(name: 'Auste8')
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      get "/api/v1/merchants/#{merchant.id}/invoices", format: :json

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
      expect(invoice_response.first['merchant_id']).to eq(merchant.id)
      expect(invoice_response.second['merchant_id']).to eq(merchant.id)
    end
  end
end
