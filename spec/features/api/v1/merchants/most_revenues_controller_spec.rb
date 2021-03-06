require 'rails_helper'

RSpec.describe "/api/v1/merchants", type: :request do
#BI - All Merchants: GET /api/v1/merchants/most_revenue?quantity=x
  #returns the top x merchants ranked by total revenue

  context 'GET /api/v1/merchants/most_revenue?quantity=x' do
    it 'returns top x merchants ranked by total revenue' do
      # there are 5 merchants
      # first merchant has 2 invoices and revenue: 51
      customer1 = Customer.create!(first_name: 'strawberry', last_name: 'red')
      merchant1 = Merchant.create!(name: 'Jorge')
      invoice1 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant1.id, status: "success")
      invoice2 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant1.id, status: "success")
      Transaction.create!(invoice_id: invoice1.id, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: invoice2.id, credit_card_number: '78', result: 'success')
      invoice_item1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: 18, quantity: 1, unit_price: 17)
      invoice_item2 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: 18, quantity: 2, unit_price: 17)

      # second merchant has 1 invoices and revenue: 34
      merchant2 = Merchant.create!(name: 'Austen')
      invoice3 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant2.id, status: "success")
      Transaction.create!(invoice_id: invoice3.id, credit_card_number: '78', result: 'success')
      invoice_item3 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: 18, quantity: 1, unit_price: 17)
      invoice_item4 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: 18, quantity: 1, unit_price: 17)

      # third merchant has 1 invoices and revenue: 136
      merchant3 = Merchant.create!(name: 'Bill')
      invoice4 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant3.id, status: "success")
      Transaction.create!(invoice_id: invoice4.id, credit_card_number: '78', result: 'success')
      invoice_item5 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: 18, quantity: 6, unit_price: 17)
      invoice_item6 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: 18, quantity: 2, unit_price: 17)

      # fourth merchant has 2 invoices and revenue: 85
      merchant4 = Merchant.create!(name: 'John')
      invoice5 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant4.id, status: "success")
      invoice6 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant4.id, status: "success")
      Transaction.create!(invoice_id: invoice5.id, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: invoice6.id, credit_card_number: '78', result: 'success')
      invoice_item7 = InvoiceItem.create!(invoice_id: invoice5.id, item_id: 18, quantity: 1, unit_price: 17)
      invoice_item8 = InvoiceItem.create!(invoice_id: invoice6.id, item_id: 18, quantity: 4, unit_price: 17)

      # fifth merchant has 2 invoices and revenue: 68
      merchant5 = Merchant.create!(name: 'Steve')
      invoice7 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant5.id, status: "success")
      invoice8 = Invoice.create!(customer_id: customer1.id, merchant_id: merchant5.id, status: "success")
      Transaction.create!(invoice_id: invoice7.id, credit_card_number: '78', result: 'success')
      Transaction.create!(invoice_id: invoice8.id, credit_card_number: '78', result: 'success')
      invoice_item9 = InvoiceItem.create!(invoice_id: invoice7.id, item_id: 18, quantity: 1, unit_price: 17)
      invoice_item10 = InvoiceItem.create!(invoice_id: invoice8.id, item_id: 18, quantity: 3, unit_price: 17)

      get "/api/v1/merchants/most_revenue", quantity: 3, format: :json

      expect(response).to have_http_status(:ok)
      most_revenue_response = JSON.parse(response.body)
      expect(most_revenue_response.class).to eq(Array)
      expect(most_revenue_response.first["name"]).to eq('Bill')
      expect(most_revenue_response.second["name"]).to eq('John')
      expect(most_revenue_response.third["name"]).to eq('Steve')
      expect(most_revenue_response.count).to eq(3)
    end
  end

end
