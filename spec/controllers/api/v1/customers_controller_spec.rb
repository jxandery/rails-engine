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
end
