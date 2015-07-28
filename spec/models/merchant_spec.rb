require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe 'has many relationships' do
    it 'has many items' do
      merch = Merchant.create!(name: "merch1")
      expect(merch.items.count).to eq(0)

      item1 = Item.create!(name: "item1", description: "desc1", unit_price: 19, merchant_id: merch.id)
      item2 = Item.create!(name: "item2", description: "desc2", unit_price: 29, merchant_id: merch.id)

      expect(merch.items.count).to eq(2)
    end

    it 'has many invoices' do
      merch = Merchant.create!(name: "merch1")
      customer = Customer.create!(first_name: "jack", last_name: "yeh")
      expect(merch.invoices.count).to eq(0)

      invoice1 = Invoice.create!(customer_id: customer.id, merchant_id: merch.id, status: "does it really matter")
      invoice2 = Invoice.create!(customer_id: customer.id, merchant_id: merch.id, status: "you bet it does")

      expect(merch.invoices.count).to eq(2)
    end
  end
end
