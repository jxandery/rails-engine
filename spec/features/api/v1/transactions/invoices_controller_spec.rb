require 'rails_helper'

RSpec.describe "/api/v1/transactions", type: :request do

  context 'GET /api/v1/transactions/:transaction_id/invoice' do
    it 'returns specific invoice' do
      invoice = Invoice.create!(customer_id: 3, merchant_id: 7, status: "success")
      transaction = Transaction.create!(invoice_id: invoice.id, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      get "/api/v1/transactions/#{transaction.id}/invoice", format: :json

      expect(response).to have_http_status(:ok)
      transaction_response = JSON.parse(response.body)
      expect(transaction_response['customer_id']).to eq(3)
      expect(transaction_response['merchant_id']).to eq(7)
      expect(transaction_response['status']).to eq('success')
    end
  end
end
