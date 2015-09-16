require 'rails_helper'

RSpec.describe "/api/v1/invoices", type: :request do

  context 'GET /api/v1/invoices/:id/merchant' do
    it 'returns merchant' do
      merchant = Merchant.create!(name: 'Austen')
      invoice = Invoice.create!(customer_id: 99, merchant_id: merchant.id, status: "fair")
      get "/api/v1/invoices/#{invoice.id}/merchant", format: :json

      expect(response).to have_http_status(:ok)
      merchant_response = JSON.parse(response.body)
      expect(merchant_response.class).to eq(Hash)
      expect(merchant_response['name']).to eq('Austen')
    end
  end
end
