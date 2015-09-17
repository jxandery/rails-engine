require 'rails_helper'

RSpec.describe "/api/v1/customers", type: :request do

  context 'GET /api/v1/customers/:customer_id/transactions' do
    it 'returns transactions' do
      merchant = Merchant.create!(name: 'Austen')
      customer = Customer.create!(first_name: 'strawberry', last_name: 'red')
      invoice = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "success")
      transaction1 = Transaction.create!(invoice_id: invoice.id, credit_card_number: '78', result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice.id, credit_card_number: '88', result: 'success')
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
end
