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

  context 'GET /api/v1/invoices/:id/customer' do
    it 'returns customer' do
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice = Invoice.create!(customer_id: customer.id, merchant_id: 88, status: "fair")
      get "/api/v1/invoices/#{invoice.id}/customer", format: :json

      expect(response).to have_http_status(:ok)
      customer_response = JSON.parse(response.body)
      expect(customer_response.class).to eq(Hash)
      expect(customer_response['first_name']).to eq('strawberry')
      expect(customer_response['last_name']).to eq('red')
    end
  end

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

  context 'GET /api/v1/invoices/:id/transactions' do
    it 'returns transactions' do
      merchant = Merchant.create!(name: 'Austen')
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      transaction1 = Transaction.create!(invoice_id: invoice.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice.id, credit_card_number: '88', credit_card_expiration_date: '08081978', result: 'success')
      get "/api/v1/invoices/#{invoice.id}/transactions", format: :json

      expect(response).to have_http_status(:ok)
      transactions_response = JSON.parse(response.body)
      expect(transactions_response.count).to eq(2)
      expect(transactions_response.first['invoice_id']).to eq(invoice.id)
      expect(transactions_response.first['credit_card_number']).to eq('78')
      expect(transactions_response.second['invoice_id']).to eq(invoice.id)
      expect(transactions_response.second['credit_card_number']).to eq('88')
    end
  end

  context 'GET /api/v1/invoices/:id/invoice_items' do
    it 'returns invoice_items' do
      merchant = Merchant.create!(name: 'Austen')
      item = Item.create!(name: 'item9', description: 'description9', unit_price: 99, merchant_id: merchant.id)
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      invoice_items1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item.id, quantity: 100, unit_price: 77)
      invoice_items2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item.id, quantity: 111, unit_price: 11)
      get "/api/v1/invoices/#{invoice1.id}/invoice_items", format: :json

      expect(response).to have_http_status(:ok)
      invoice_items_response = JSON.parse(response.body)
      expect(invoice_items_response.count).to eq(2)
      expect(invoice_items_response.first['invoice_id']).to eq(invoice1.id)
      expect(invoice_items_response.first['item_id']).to eq(item.id)
      expect(invoice_items_response.first['quantity']).to eq(100)
      expect(invoice_items_response.first['unit_price']).to eq(77)
      expect(invoice_items_response.second['invoice_id']).to eq(invoice1.id)
      expect(invoice_items_response.second['item_id']).to eq(item.id)
      expect(invoice_items_response.second['quantity']).to eq(111)
      expect(invoice_items_response.second['unit_price']).to eq(11)
    end
  end

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
      expect(items_response.first['unit_price']).to eq(99)
      expect(items_response.second['name']).to eq('item2')
      expect(items_response.second['description']).to eq('description2')
      expect(items_response.second['merchant_id']).to eq(merchant.id)
      expect(items_response.second['unit_price']).to eq(29)
    end
  end
end