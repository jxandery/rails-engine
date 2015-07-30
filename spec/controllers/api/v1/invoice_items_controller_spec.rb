require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
  context '#index' do
    it 'returns all the invoice_items' do
      InvoiceItem.create!(invoice_id: 99, item_id: 88, quantity: 100, unit_price: 77)
      get :index, format: :json

      expect(response).to have_http_status(:ok)
      invoice_items = JSON.parse(response.body)
      expect(invoice_items.count).to eq(1)

      invoice_item = invoice_items.first
      expect(invoice_item['invoice_id']).to eq(99)
      expect(invoice_item['item_id']).to eq(88)
      expect(invoice_item['quantity']).to eq(100)
      expect(invoice_item['unit_price']).to eq(77)
    end
  end

  context '#show' do
    it 'returns individual invoice_item' do
      invoice_item = InvoiceItem.create!(invoice_id: 99, item_id: 88, quantity: 100, unit_price: 77)
      get :show, id: invoice_item.id, format: :json

      expect(response).to have_http_status(:ok)
      invoice_item_response = JSON.parse(response.body)
      expect(invoice_item['invoice_id']).to eq(99)
      expect(invoice_item['item_id']).to eq(88)
      expect(invoice_item['quantity']).to eq(100)
      expect(invoice_item['unit_price']).to eq(77)
    end
  end
end
