require 'rails_helper'

RSpec.describe "/api/v1/customers", type: :request do

  context 'GET /api/v1/customers' do
    it 'returns all the customers' do
      Customer.create!(first_name: 'strawberry', last_name: 'red')
      get "/api/v1/customers", format: :json

      expect(response).to have_http_status(:ok)
      customers = JSON.parse(response.body)
      expect(customers.count).to eq(1)

      customer = customers.first
      expect(customer['first_name']).to eq('strawberry')
      expect(customer['last_name']).to eq('red')
    end
  end

  context 'GET /api/v1/customers/:id' do
    it 'returns individual customer' do
      customer = Customer.create!(first_name: 'cinnamon', last_name: 'none')
      get "/api/v1/customers/#{customer.id}", format: :json

      expect(response).to have_http_status(:ok)
      customer_response = JSON.parse(response.body)
      expect(customer_response['first_name']).to eq('cinnamon')
      expect(customer_response['last_name']).to eq('none')
    end
  end

  context 'GET /api/v1/customers/random' do
    it 'returns random customer' do
      Customer.create!(first_name: 'customer1', last_name: 'last1')
      Customer.create!(first_name: 'customer2', last_name: 'last2')
      Customer.create!(first_name: 'customer3', last_name: 'last3')
      Customer.create!(first_name: 'customer4', last_name: 'last4')
      Customer.create!(first_name: 'customer5', last_name: 'last5')
      Customer.create!(first_name: 'customer6', last_name: 'last6')
      Customer.create!(first_name: 'customer7', last_name: 'last7')
      Customer.create!(first_name: 'customer8', last_name: 'last8')
      Customer.create!(first_name: 'customer8', last_name: 'last9')
      get "/api/v1/customers/random", format: :json

      expect(response).to have_http_status(:ok)
      customer_response = JSON.parse(response.body)
      expect(customer_response).not_to eq(Customer.all.sample)
    end
  end

  context 'GET /api/v1/customers/find' do
    it 'returns specific customer' do
      customer1 = Customer.create!(first_name: 'customer1', last_name: 'last1')
      customer2 = Customer.create!(first_name: 'customer2', last_name: 'last2')
      get "/api/v1/customers/find", first_name: customer2.first_name, format: :json

      expect(response).to have_http_status(:ok)
      customer_response = JSON.parse(response.body)
      expect(customer_response['first_name']).to eq('customer2')
      expect(customer_response['last_name']).to eq('last2')
    end
  end

  context 'GET /api/v1/customers/find_all' do
    it 'returns all customers' do
      Customer.create!(first_name: 'billy', last_name: 'last1')
      Customer.create!(first_name: 'billy', last_name: 'last2')
      get "/api/v1/customers/find_all", first_name: 'billy', format: :json

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
    end
  end

  context 'GET /api/v1/customers/:customer_id/invoices' do
    it 'returns invoices', type: :request do
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice1 = Invoice.create!(customer_id: customer.id, merchant_id: 9, status: "success")
      invoice2 = Invoice.create!(customer_id: customer.id, merchant_id: 3, status: "success")
      get "/api/v1/customers/#{customer.id}/invoices"

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
      expect(invoice_response.first['merchant_id']).to eq(9)
      expect(invoice_response.second['merchant_id']).to eq(3)
    end
  end

  context 'GET /api/v1/customers/:customer_id/transactions' do
    it 'returns transactions' do
      merchant = Merchant.create!(name: 'Austen')
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      transaction1 = Transaction.create!(invoice_id: invoice.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice.id, credit_card_number: '88', credit_card_expiration_date: '08081978', result: 'success')
      get "/api/v1/customers/#{customer.id}/transactions"

      expect(response).to have_http_status(:ok)
      transactions_response = JSON.parse(response.body)
      expect(transactions_response.count).to eq(2)
      expect(transactions_response.first['invoice_id']).to eq(invoice.id)
      expect(transactions_response.first['credit_card_number']).to eq('78')
      expect(transactions_response.second['invoice_id']).to eq(invoice.id)
      expect(transactions_response.second['credit_card_number']).to eq('88')
    end
  end

  context 'GET /api/v1/customers/:customer_id/favorite_merchant' do
    it 'returns favorite_merchant' do
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      merchant1 = Merchant.create!(name: 'Jorge')
      merchant2 = Merchant.create!(name: 'Austen')
      invoice1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant1.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer.id, merchant_id: merchant1.id, status: "success")
      invoice3 = Invoice.create!(customer_id: customer.id, merchant_id: merchant2.id, status: "success")
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '88', credit_card_expiration_date: '08081978', result: 'success')
      transaction3 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      expect(response).to have_http_status(:ok)
      favorite_merchant_response = JSON.parse(response.body)
      expect(favorite_merchant_response.class).to eq(Hash)
      expect(favorite_merchant_response['name']).to eq('Jorge')
    end
  end

end
