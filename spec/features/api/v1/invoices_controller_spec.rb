require 'rails_helper'

RSpec.describe "/api/v1/invoices", type: :request do

  context 'GET /api/v1/invoices' do
    it 'returns all the invoices' do
      Invoice.create!(customer_id: 99, merchant_id: 88, status: "fair")
      get "/api/v1/invoices", format: :json

      expect(response).to have_http_status(:ok)
      invoices = JSON.parse(response.body)
      expect(invoices.count).to eq(1)

      invoice = invoices.first
      expect(invoice['customer_id']).to eq(99)
      expect(invoice['merchant_id']).to eq(88)
      expect(invoice['status']).to eq('fair')
    end
  end

  context 'GET /api/v1/invoices/:id' do
    it 'returns individual invoice' do
      invoice = Invoice.create!(customer_id: 99, merchant_id: 88, status: "fair")
      get "/api/v1/invoices/#{invoice.id}", format: :json

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice['customer_id']).to eq(99)
      expect(invoice['merchant_id']).to eq(88)
      expect(invoice['status']).to eq('fair')
    end
  end

  context 'GET /api/v1/invoices/random' do
    it 'returns random invoice' do
      Invoice.create!(customer_id: 19, merchant_id: 81, status: "fair")
      Invoice.create!(customer_id: 29, merchant_id: 82, status: "fair")
      Invoice.create!(customer_id: 39, merchant_id: 83, status: "fair")
      Invoice.create!(customer_id: 49, merchant_id: 84, status: "fair")
      Invoice.create!(customer_id: 59, merchant_id: 85, status: "fair")
      Invoice.create!(customer_id: 69, merchant_id: 86, status: "fair")
      Invoice.create!(customer_id: 79, merchant_id: 87, status: "fair")
      Invoice.create!(customer_id: 89, merchant_id: 88, status: "fair")
      Invoice.create!(customer_id: 99, merchant_id: 89, status: "fair")
      get "/api/v1/invoices/random", format: :json
      #get :random, format: :json

      expect(response).to have_http_status(:ok)
      invoice_response= JSON.parse(response.body)
      expect(invoice_response).not_to eq(Invoice.all.sample)
    end
  end

  context 'GET /api/v1/invoices/find' do
    it 'returns specific invoice' do
      invoice1 = Invoice.create!(customer_id: 89, merchant_id: 88, status: "tbd")
      invoice2 = Invoice.create!(customer_id: 99, merchant_id: 89, status: "fair")
      get "/api/v1/invoices/find", customer_id: invoice2.customer_id, format: :json

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response['customer_id']).to eq(99)
      expect(invoice_response['merchant_id']).to eq(89)
      expect(invoice_response['status']).to eq('fair')
    end
  end

  context 'GET /api/v1/invoices/find_all' do
    it 'returns all invoices' do
      Invoice.create!(customer_id: 89, merchant_id: 88, status: "tbd")
      Invoice.create!(customer_id: 99, merchant_id: 88, status: "fair")
      get "/api/v1/invoices/find_all", merchant_id: 88, format: :json

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
    end
  end
end
