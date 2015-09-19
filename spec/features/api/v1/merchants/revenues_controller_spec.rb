require 'rails_helper'

RSpec.describe "/api/v1/merchants", type: :request do
#BI - Single Merchant: GET /api/v1/merchants/:id/revenue?date=x
  #returns the total revenue for that merchant for a specific invoice date x

  context 'GET /api/v1/merchants/:merchant_id/revenue' do
    it 'returns revenue for a specific invoice date' do
      merchant = Merchant.create!(name: 'Auste8')
      customer1 = Customer.create!(first_name: 'strawberry', last_name: 'red')
      customer2 = Customer.create!(first_name: 'cherry', last_name: 'black')
      invoice1 = Invoice.create!(customer_id: customer1.id, created_at: "2012-03-16 11:55:05", merchant_id: merchant.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer1.id, created_at: "2012-03-16 11:55:05", merchant_id: merchant.id, status: "success")
      invoice3 = Invoice.create!(customer_id: customer2.id, created_at: "2012-03-12 11:55:05", merchant_id: merchant.id, status: "success")
      item1 = Item.create!(name: 'item9', description: 'description9', unit_price: 10, merchant_id: merchant.id)
      item2 = Item.create!(name: 'item3', description: 'description9', unit_price: 30, merchant_id: merchant.id)
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 1, unit_price: 10)
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 10)
      InvoiceItem.create!(invoice_id: invoice2.id, item_id: item2.id, quantity: 3, unit_price: 30)
      InvoiceItem.create!(invoice_id: invoice3.id, item_id: item2.id, quantity: 3, unit_price: 30)
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '78', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '78', result: 'success')
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '9807', result: 'pending')
      get "/api/v1/merchants/#{merchant.id}/revenue", date: "2012-03-16", format: :json

      expect(response).to have_http_status(:ok)
      revenue_response = JSON.parse(response.body)
      expect(revenue_response.class).to eq(Hash)
      expect(revenue_response["revenue"].to_i).to eq(120)
    end
  end

#BI - All Merchant: GET /api/v1/merchants/revenue?date=x
  #returns the total revenue for all merchant for a specific invoice date x
  context 'GET /api/v1/merchants/revenue' do
    it 'returns revenue for all merchants for specific invoice date' do
      merchant1 = Merchant.create!(name: 'Auste8')
      merchant2 = Merchant.create!(name: 'Auste8')
      customer1 = Customer.create!(first_name: 'strawberry', last_name: 'red')
      customer2 = Customer.create!(first_name: 'cherry', last_name: 'black')
      invoice1 = Invoice.create!(customer_id: customer1.id, created_at: "2012-03-16 11:55:05", merchant_id: merchant1.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer1.id, created_at: "2012-03-16 11:55:05", merchant_id: merchant1.id, status: "success")
      invoice3 = Invoice.create!(customer_id: customer2.id, created_at: "2012-03-12 11:55:05", merchant_id: merchant2.id, status: "success")
      item1 = Item.create!(name: 'item9', description: 'description9', unit_price: 10, merchant_id: merchant1.id)
      item2 = Item.create!(name: 'item3', description: 'description9', unit_price: 30, merchant_id: merchant2.id)
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 1, unit_price: 10)
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 10)
      InvoiceItem.create!(invoice_id: invoice2.id, item_id: item2.id, quantity: 3, unit_price: 30)
      InvoiceItem.create!(invoice_id: invoice3.id, item_id: item2.id, quantity: 3, unit_price: 30)
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '78', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '78', result: 'success')
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '9807', result: 'success')
      get "/api/v1/merchants/#{merchant1.id}/revenue", date: "2012-03-16", format: :json

      expect(response).to have_http_status(:ok)
      revenue_response = JSON.parse(response.body)
      expect(revenue_response.class).to eq(Hash)
      expect(revenue_response["revenue"].to_i).to eq(120)
    end
  end
end
