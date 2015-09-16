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
end
