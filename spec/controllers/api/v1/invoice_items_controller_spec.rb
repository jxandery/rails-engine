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

      get :random, format: :json

      expect(response).to have_http_status(:ok)
      invoice_item_response= JSON.parse(response.body)
      expect(invoice_item_response).not_to eq(InvoiceItem.all.sample)
    end
  end

  context '#find' do
    it 'returns specific invoice_item' do
      invoice_item1 = InvoiceItem.create!(invoice_id: 19, item_id: 18, quantity: 119, unit_price: 17)
      invoice_item2 = InvoiceItem.create!(invoice_id: 99, item_id: 98, quantity: 109, unit_price: 97)
      get :find, item_id: invoice_item2.item_id

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
      get :find_all, invoice_id: 19

      expect(response).to have_http_status(:ok)
      invoice_item = JSON.parse(response.body)
      expect(invoice_item.count).to eq(2)
    end
  end

  context '#invoice' do
    it 'returns specific invoice' do
      invoice = Invoice.create!(customer_id: 3, merchant_id: 7, status: "success")
      invoice_item1 = InvoiceItem.create!(invoice_id: invoice.id, item_id: 18, quantity: 119, unit_price: 17)
      get :invoice, invoice_item_id: invoice_item1.id

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response['customer_id']).to eq(3)
      expect(invoice_response['merchant_id']).to eq(7)
      expect(invoice_response['status']).to eq('success')
    end
  end

end
