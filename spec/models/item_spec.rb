require 'rails_helper'

RSpec.describe Item, type: :model do
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
    it 'has many invoice_items' do
      item = Item.create!(name: "item1", description: "desc1", unit_price: 19, merchant_id: merch.id)

      expect(item.invoice_items.count).to eq(0)

      invoice_item1 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 1)
      invoice_item2 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 2)

      expect(item.invoice_items.count).to eq(2)
    end
end
