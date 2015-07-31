require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do

  context '#index' do
    it 'returns all the customers' do
      Customer.create!(first_name: 'strawberry', last_name: 'red')
      get :index, format: :json

      expect(response).to have_http_status(:ok)
      customers = JSON.parse(response.body)
      expect(customers.count).to eq(1)

      customer = customers.first
      expect(customer['first_name']).to eq('strawberry')
      expect(customer['last_name']).to eq('red')
    end
  end

  context '#show' do
    it 'returns individual customer' do
      customer = Customer.create!(first_name: 'cinnamon', last_name: 'none')
      get :show, id: customer.id, format: :json

      expect(response).to have_http_status(:ok)
      customer_response = JSON.parse(response.body)
      expect(customer_response['first_name']).to eq('cinnamon')
      expect(customer_response['last_name']).to eq('none')
    end
  end

  context '#random' do
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
      get :random, format: :json

      expect(response).to have_http_status(:ok)
      customer_response = JSON.parse(response.body)
      expect(customer_response).not_to eq(Customer.all.sample)
    end
  end

  context '#find' do
    it 'returns specific customer' do
      customer1 = Customer.create!(first_name: 'customer1', last_name: 'last1')
      customer2 = Customer.create!(first_name: 'customer2', last_name: 'last2')
      get :find, first_name: customer2.first_name

      expect(response).to have_http_status(:ok)
      customer_response = JSON.parse(response.body)
      expect(customer_response['first_name']).to eq('customer2')
      expect(customer_response['last_name']).to eq('last2')
    end
  end

  context '#find_all' do
    it 'returns all customers' do
      Customer.create!(first_name: 'billy', last_name: 'last1')
      Customer.create!(first_name: 'billy', last_name: 'last2')
      get :find_all, first_name: 'billy'

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
    end
  end

  context '#invoices' do
    it 'returns transactions' do
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice1 = Invoice.create!(customer_id: customer.id, merchant_id: 9, status: "success")
      invoice2 = Invoice.create!(customer_id: customer.id, merchant_id: 3, status: "success")
      get :invoices, customer_id: customer.id

      expect(response).to have_http_status(:ok)
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
      expect(invoice_response.first['merchant_id']).to eq(9)
      expect(invoice_response.second['merchant_id']).to eq(3)
    end
  end

end
