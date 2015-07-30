require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do

  context '#index' do
    it 'returns all the transactions' do
      Transaction.create!(invoice_id: 4, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      get :index, format: :json

      expect(response).to have_http_status(:ok)
      transactions = JSON.parse(response.body)
      expect(transactions.count).to eq(1)

      transaction = transactions.first
      expect(transaction['invoice_id']).to eq(4)
      expect(transaction['credit_card_number']).to eq('78')
      expect(transaction['credit_card_expiration_date']).to eq('01011978')
      expect(transaction['result']).to eq('success')
    end
  end

  context '#show' do
    it 'returns individual transaction' do
      transaction = Transaction.create!(invoice_id: 4, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      get :show, id: transaction.id, format: :json

      expect(response).to have_http_status(:ok)
      transaction_response = JSON.parse(response.body)
      expect(transaction['invoice_id']).to eq(4)
      expect(transaction['credit_card_number']).to eq('78')
      expect(transaction['credit_card_expiration_date']).to eq('01011978')
      expect(transaction['result']).to eq('success')
    end
  end

  context '#random' do
    it 'returns random transaction' do
      Transaction.create!(invoice_id: 1, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      Transaction.create!(invoice_id: 2, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      Transaction.create!(invoice_id: 3, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      Transaction.create!(invoice_id: 4, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      Transaction.create!(invoice_id: 5, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      Transaction.create!(invoice_id: 6, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      Transaction.create!(invoice_id: 7, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      Transaction.create!(invoice_id: 8, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      Transaction.create!(invoice_id: 9, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      Transaction.create!(invoice_id: 10, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      get :random, format: :json

      expect(response).to have_http_status(:ok)
      transactions = JSON.parse(response.body)
      expect(transactions).not_to eq(Transaction.all.sample)
    end
  end

  context '#find' do
    it 'returns specific transaction' do
      transaction1 = Transaction.create!(invoice_id: 4, credit_card_number: '78', credit_card_expiration_date: '01011978', result: 'success')
      transaction2 = Transaction.create!(invoice_id: 2, credit_card_number: '9807', credit_card_expiration_date: '04041978', result: 'pending')
      get :find, invoice_id: transaction1.invoice_id, format: :json

      expect(response).to have_http_status(:ok)
      transaction_response = JSON.parse(response.body)
      expect(transaction1['invoice_id']).to eq(4)
      expect(transaction1['credit_card_number']).to eq('78')
      expect(transaction1['credit_card_expiration_date']).to eq('01011978')
      expect(transaction1['result']).to eq('success')
    end
  end
end
