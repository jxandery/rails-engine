require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  context '#index' do
    it 'returns all the invoices' do
      Invoice.create!(customer_id: 99, merchant_id: 88, status: "fair")
      get :index, format: :json

      expect(response).to have_http_status(:ok)
      invoices = JSON.parse(response.body)
      expect(invoices.count).to eq(1)

      invoice = invoices.first
      expect(invoice['customer_id']).to eq(99)
      expect(invoice['merchant_id']).to eq(88)
      expect(invoice['status']).to eq('fair')
    end
  end

  context '#show' do
    it 'returns individual invoice' do
      invoice = Invoice.create!(customer_id: 99, merchant_id: 88, status: "fair")
      get :show, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice['customer_id']).to eq(99)
      expect(invoice['merchant_id']).to eq(88)
      expect(invoice['status']).to eq('fair')
    end
  end
end
