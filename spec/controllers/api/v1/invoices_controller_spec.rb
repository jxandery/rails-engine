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

  context '#merchant' do
    it 'returns merchant' do
      merchant = Merchant.create!(name: 'Austen')
      invoice = Invoice.create!(customer_id: 99, merchant_id: merchant.id, status: "fair")
      get :merchant, invoice_id: invoice.id

      expect(response).to have_http_status(:ok)
      merchant_response = JSON.parse(response.body)
      expect(merchant_response.class).to eq(Hash)
      expect(merchant_response['name']).to eq('Austen')
    end
  end

  context '#transactions' do
    it 'returns transactions' do
      merchant = Merchant.create!(name: 'Austen')
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      transaction1 = Transaction.create!(invoice_id: invoice.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice.id, credit_card_number: '88', credit_card_expiration_date: '08081978', result: 'success')
      get :transactions, invoice_id: invoice.id

      expect(response).to have_http_status(:ok)
      transactions_response = JSON.parse(response.body)
      expect(transactions_response.count).to eq(2)
      expect(transactions_response.first['invoice_id']).to eq(invoice.id)
      expect(transactions_response.first['credit_card_number']).to eq('78')
      expect(transactions_response.second['invoice_id']).to eq(invoice.id)
      expect(transactions_response.second['credit_card_number']).to eq('88')
    end
  end

  context '#invoice_items' do
    it 'returns invoice_items' do
      merchant = Merchant.create!(name: 'Austen')
      item = Item.create!(name: 'item9', description: 'description9', unit_price: 99, merchant_id: merchant.id)
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      invoice_items1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item.id, quantity: 100, unit_price: 77)
      invoice_items2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item.id, quantity: 111, unit_price: 11)
      get :invoice_items, invoice_id: invoice1.id

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
end
