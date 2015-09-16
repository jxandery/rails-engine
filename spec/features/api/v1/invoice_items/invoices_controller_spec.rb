require 'rails_helper'

RSpec.describe "/api/v1/invoice_items", type: :request do

  context 'GET /api/v1/invoice_items/:invoice_item_id/invoice' do
    it 'returns specific invoice' do
      invoice = Invoice.create!(customer_id: 3, merchant_id: 7, status: "success")
      invoice_item1 = InvoiceItem.create!(invoice_id: invoice.id, item_id: 18, quantity: 119, unit_price: 17)
      get "/api/v1/invoice_items/#{invoice_item1.id}/invoice", invoice_id: 19, format: :json

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response['customer_id']).to eq(3)
      expect(invoice_response['merchant_id']).to eq(7)
      expect(invoice_response['status']).to eq('success')
    end
  end
end
