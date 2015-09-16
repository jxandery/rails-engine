require 'rails_helper'

RSpec.describe "/api/v1/merchants", type: :request do

  context 'GET /api/v1/merchants/:merchant_id/revenue' do
    it 'returns revenue' do
      merchant = Merchant.create!(name: 'Auste8')
      customer1 = Customer.create!(first_name: 'strawberry', last_name: 'red')
      customer2 = Customer.create!(first_name: 'cherry', last_name: 'black')
      invoice1 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant.id, status: "success")
      invoice3 = Invoice.create!(customer_id: customer2.id, merchant_id: merchant.id, status: "success")
      item1 = Item.create!(name: 'item9', description: 'description9', unit_price: 10, merchant_id: merchant.id)
      item2 = Item.create!(name: 'item3', description: 'description9', unit_price: 30, merchant_id: merchant.id)
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 1, unit_price: 10)
      InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 10)
      InvoiceItem.create!(invoice_id: invoice2.id, item_id: item2.id, quantity: 3, unit_price: 30)
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '9807', credit_card_expiration_date: '04041978', result: 'pending')
      get "/api/v1/merchants/#{merchant.id}/revenue", format: :json

      expect(response).to have_http_status(:ok)
      revenue_response = JSON.parse(response.body)
      expect(revenue_response.class).to eq(Hash)
      expect(revenue_response["revenue"].to_i).to eq(120)
    end
  end
end
