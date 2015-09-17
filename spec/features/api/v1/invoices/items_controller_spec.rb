require 'rails_helper'

RSpec.describe "/api/v1/invoices", type: :request do

  context 'GET /api/v1/invoices/:id/items' do
    it 'returns items' do
      merchant = Merchant.create!(name: 'Austen')
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      item1 = Item.create!(name: 'item9', description: 'description9', unit_price: 99, merchant_id: merchant.id)
      item2 = Item.create!(name: 'item2', description: 'description2', unit_price: 29, merchant_id: merchant.id)
      invoice_items1 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item1.id, quantity: 100, unit_price: 77)
      invoice_items2 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item2.id, quantity: 111, unit_price: 11)
      get "/api/v1/invoices/#{invoice.id}/items", format: :json

      expect(response).to have_http_status(:ok)
      items_response = JSON.parse(response.body)
      expect(items_response.count).to eq(2)
      expect(items_response.first['name']).to eq('item9')
      expect(items_response.first['description']).to eq('description9')
      expect(items_response.first['merchant_id']).to eq(merchant.id)
      expect(items_response.first['unit_price']).to eq("99.0")
      expect(items_response.second['name']).to eq('item2')
      expect(items_response.second['description']).to eq('description2')
      expect(items_response.second['merchant_id']).to eq(merchant.id)
      expect(items_response.second['unit_price']).to eq("29.0")
    end
  end

end
