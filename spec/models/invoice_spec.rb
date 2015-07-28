require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:merch) do
    Merchant.create!(name: "merch1")
  end

  let(:customer) do
    Customer.create!(first_name: "jack", last_name: "yeh")
  end

  let(:invoice) do
    Invoice.create!(customer_id: customer.id, merchant_id: merch.id, status: "does it really matter")
  end

  describe 'has many relationships' do
    it 'has many transactions' do
      expect(invoice.transactions.count).to eq(0)
      trans1 = Transaction.create!(invoice_id: invoice.id)
      trans2 = Transaction.create!(invoice_id: invoice.id)
      expect(invoice.transactions.count).to eq(2)
    end

    it 'has many invoice_items' do
      item1 = Item.create!(name: "item1", description: "desc1", unit_price: 19, merchant_id: merch.id)
      item2 = Item.create!(name: "item2", description: "desc2", unit_price: 29, merchant_id: merch.id)

      expect(invoice.invoice_items.count).to eq(0)

      invoice_item1 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item1.id, quantity: 1)
      invoice_item2 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item2.id, quantity: 2)

      expect(invoice.invoice_items.count).to eq(2)
    end

    it 'has many items through invoice_items' do
      item1 = Item.create!(name: "item1", description: "desc1", unit_price: 19, merchant_id: merch.id)
      item2 = Item.create!(name: "item2", description: "desc2", unit_price: 29, merchant_id: merch.id)

      expect(invoice.items.count).to eq(0)

      invoice_item1 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item1.id, quantity: 1)
      invoice_item2 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item2.id, quantity: 2)

      expect(invoice.items.count).to eq(2)
    end
  end
end
