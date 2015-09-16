require 'rails_helper'

RSpec.describe "/api/v1/customers", type: :request do

  context 'GET /api/v1/customers/:customer_id/invoices' do
    it 'returns invoices', type: :request do
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice1 = Invoice.create!(customer_id: customer.id, merchant_id: 9, status: "success")
      invoice2 = Invoice.create!(customer_id: customer.id, merchant_id: 3, status: "success")
      get "/api/v1/customers/#{customer.id}/invoices"

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
      expect(invoice_response.first['merchant_id']).to eq(9)
      expect(invoice_response.second['merchant_id']).to eq(3)
    end
  end
end
