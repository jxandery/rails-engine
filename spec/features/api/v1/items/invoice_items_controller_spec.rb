require 'rails_helper'

RSpec.describe "/api/v1/items", type: :request do

  context 'GET /api/v1/items/:item_id/invoice_items' do
    it 'returns invoice_items' do
      merchant = Merchant.create!(name: 'Austen')
      item = Item.create!(name: 'item9', description: 'description9', unit_price: 99, merchant_id: merchant.id)
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      invoice_items1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item.id, quantity: 100, unit_price: 77)
      invoice_items2 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item.id, quantity: 111, unit_price: 11)
      get "/api/v1/items/#{item.id}/invoice_items", format: :json

      expect(response).to have_http_status(:ok)
      invoice_items_response = JSON.parse(response.body)
      expect(invoice_items_response.count).to eq(2)
      expect(invoice_items_response.first['invoice_id']).to eq(invoice1.id)
      expect(invoice_items_response.first['item_id']).to eq(item.id)
      expect(invoice_items_response.first['quantity']).to eq(100)
      expect(invoice_items_response.first['unit_price']).to eq("77.0")
    end
  end
end
