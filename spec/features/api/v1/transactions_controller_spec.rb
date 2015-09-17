require 'rails_helper'

RSpec.describe "/api/v1/transactions", type: :request do

  context 'GET /api/v1/transactions' do
    it 'returns all the transactions' do
      Transaction.create!(invoice_id: 4, credit_card_number: '78', result: 'success')
      get "/api/v1/transactions", format: :json

      expect(response).to have_http_status(:ok)
      transactions = JSON.parse(response.body)
      expect(transactions.count).to eq(1)

      transaction = transactions.first
      expect(transaction['invoice_id']).to eq(4)
      expect(transaction['credit_card_number']).to eq('78')
      expect(transaction['result']).to eq('success')
    end
  end

  context 'GET /api/v1/transactions/:id' do
    it 'returns individual transaction' do
      transaction = Transaction.create!(invoice_id: 4, credit_card_number: '78', result: 'success')
      get "/api/v1/transactions/#{transaction.id}", format: :json

      expect(response).to have_http_status(:ok)
      transaction_response = JSON.parse(response.body)
      expect(transaction['invoice_id']).to eq(4)
      expect(transaction['credit_card_number']).to eq('78')
      expect(transaction['result']).to eq('success')
    end
  end

  context 'GET /api/v1/transactions/random' do
    it 'returns random transaction' do
      Transaction.create!(invoice_id: 1, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: 2, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: 3, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: 4, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: 5, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: 6, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: 7, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: 8, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: 9, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: 10, credit_card_number: '78', result: 'success')
      get "/api/v1/transactions/random", format: :json

      expect(response).to have_http_status(:ok)
      transactions = JSON.parse(response.body)
      expect(transactions).not_to eq(Transaction.all.sample)
    end
  end

  context 'GET /api/v1/transactions/find' do
    it 'returns specific transaction' do
      transaction1 = Transaction.create!(invoice_id: 4, credit_card_number: '78', result: 'success')
      transaction2 = Transaction.create!(invoice_id: 2, credit_card_number: '9807', result: 'pending')
      get "/api/v1/transactions/find", invoice_id: transaction1.invoice_id, format: :json

      expect(response).to have_http_status(:ok)
      transaction_response = JSON.parse(response.body)
      expect(transaction1['invoice_id']).to eq(4)
      expect(transaction1['credit_card_number']).to eq('78')
      expect(transaction1['result']).to eq('success')
    end
  end

  context 'GET /api/v1/transactions/find_all' do
    it 'returns all transactions' do
      transaction1 = Transaction.create!(invoice_id: 4, credit_card_number: '78', result: 'success')
      transaction2 = Transaction.create!(invoice_id: 2, credit_card_number: '78', result: 'pending')
      get "/api/v1/transactions/find_all", credit_card_number: 78, format: :json

      expect(response).to have_http_status(:ok)
      transaction_response = JSON.parse(response.body)
      expect(transaction_response.count).to eq(2)
    end
  end
end
