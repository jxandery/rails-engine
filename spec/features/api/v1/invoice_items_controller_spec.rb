require 'rails_helper'

RSpec.describe "/api/v1/invoice_items", type: :request do
  context '#index' do
    it 'returns all the invoice_items' do
      InvoiceItem.create!(invoice_id: 99, item_id: 88, quantity: 100, unit_price: 77)
      get "/api/v1/invoice_items", format: :json

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
      get "/api/v1/invoice_items/#{invoice_item.id}", format: :json

      expect(response).to have_http_status(:ok)
      invoice_item_response = JSON.parse(response.body)
      expect(invoice_item['invoice_id']).to eq(99)
      expect(invoice_item['item_id']).to eq(88)
      expect(invoice_item['quantity']).to eq(100)
      expect(invoice_item['unit_price']).to eq(77)
    end
  end

  context '#random' do
    it 'returns random invoice_item' do
      InvoiceItem.create!(invoice_id: 19, item_id: 18, quantity: 101, unit_price: 17)
      InvoiceItem.create!(invoice_id: 29, item_id: 28, quantity: 102, unit_price: 27)
      InvoiceItem.create!(invoice_id: 39, item_id: 38, quantity: 103, unit_price: 37)
      InvoiceItem.create!(invoice_id: 49, item_id: 48, quantity: 104, unit_price: 47)
      InvoiceItem.create!(invoice_id: 59, item_id: 58, quantity: 105, unit_price: 57)
      InvoiceItem.create!(invoice_id: 69, item_id: 68, quantity: 106, unit_price: 67)
      InvoiceItem.create!(invoice_id: 79, item_id: 78, quantity: 107, unit_price: 77)
      InvoiceItem.create!(invoice_id: 89, item_id: 88, quantity: 108, unit_price: 87)
      InvoiceItem.create!(invoice_id: 99, item_id: 98, quantity: 109, unit_price: 97)
      get "/api/v1/invoice_items/random", format: :json

      expect(response).to have_http_status(:ok)
      invoice_item_response= JSON.parse(response.body)
      expect(invoice_item_response).not_to eq(InvoiceItem.all.sample)
    end
  end

  context '#find' do
    it 'returns specific invoice_item' do
      invoice_item1 = InvoiceItem.create!(invoice_id: 19, item_id: 18, quantity: 119, unit_price: 17)
      invoice_item2 = InvoiceItem.create!(invoice_id: 99, item_id: 98, quantity: 109, unit_price: 97)
      get "/api/v1/invoice_items/find", item_id: invoice_item2.item_id, format: :json

      expect(response).to have_http_status(:ok)
      invoice_item = JSON.parse(response.body)
      expect(invoice_item['invoice_id']).to eq(99)
      expect(invoice_item['item_id']).to eq(98)
      expect(invoice_item['quantity']).to eq(109)
      expect(invoice_item['unit_price']).to eq(97)
    end
  end

  context '#find_all' do
    it 'returns all invoice_item' do
      invoice_item1 = InvoiceItem.create!(invoice_id: 19, item_id: 18, quantity: 119, unit_price: 17)
      invoice_item2 = InvoiceItem.create!(invoice_id: 19, item_id: 98, quantity: 109, unit_price: 97)
      get "/api/v1/invoice_items/find_all", invoice_id: 19, format: :json

      expect(response).to have_http_status(:ok)
      invoice_item = JSON.parse(response.body)
      expect(invoice_item.count).to eq(2)
    end
  end

  context '#invoice' do
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

  context '#item' do
    it 'returns specific item' do
      item = Item.create!(name: 'item9', description: 'description9', unit_price: 99, merchant_id: 9)
      invoice_item1 = InvoiceItem.create!(invoice_id: 8, item_id: item.id, quantity: 119, unit_price: 17)
      get "/api/v1/invoice_items/#{invoice_item1.id}/item", invoice_id: 19, format: :json

      expect(response).to have_http_status(:ok)
      item_response = JSON.parse(response.body)
      expect(item_response['name']).to eq('item9')
      expect(item_response['description']).to eq('description9')
      expect(item_response['unit_price']).to eq(99)
      expect(item_response['merchant_id']).to eq(9)
    end
  end

end
