require 'rails_helper'

RSpec.describe "/api/v1/invoices", type: :request do

  context 'GET /api/v1/invoices/:id/customer' do
    it 'returns customer' do
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice = Invoice.create!(customer_id: customer.id, merchant_id: 88, status: "fair")
      get "/api/v1/invoices/#{invoice.id}/customer", format: :json

      expect(response).to have_http_status(:ok)
      customer_response = JSON.parse(response.body)
      expect(customer_response.class).to eq(Hash)
      expect(customer_response['first_name']).to eq('strawberry')
      expect(customer_response['last_name']).to eq('red')
    end
  end
end
