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

  context '#random' do
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
      get :random, format: :json

      expect(response).to have_http_status(:ok)
      invoice_response= JSON.parse(response.body)
      expect(invoice_response).not_to eq(Invoice.all.sample)
    end
  end

  context '#find' do
    it 'returns specific invoice' do
      invoice1 = Invoice.create!(customer_id: 89, merchant_id: 88, status: "tbd")
      invoice2 = Invoice.create!(customer_id: 99, merchant_id: 89, status: "fair")
      get :find, customer_id: invoice2.customer_id

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response['customer_id']).to eq(99)
      expect(invoice_response['merchant_id']).to eq(89)
      expect(invoice_response['status']).to eq('fair')
    end
  end

  context '#find_all' do
    it 'returns all invoices' do
      Invoice.create!(customer_id: 89, merchant_id: 88, status: "tbd")
      Invoice.create!(customer_id: 99, merchant_id: 88, status: "fair")
      get :find_all, merchant_id: 88

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
    end
  end

  context '#customer' do
    it 'returns customer' do
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice = Invoice.create!(customer_id: customer.id, merchant_id: 88, status: "fair")
      get :customer, invoice_id: invoice.id

      expect(response).to have_http_status(:ok)
      customer_response = JSON.parse(response.body)
      expect(customer_response.class).to eq(Hash)
      expect(customer_response['first_name']).to eq('strawberry')
      expect(customer_response['last_name']).to eq('red')
    end
  end
end
