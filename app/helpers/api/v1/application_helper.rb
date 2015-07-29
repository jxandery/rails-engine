module Api::V1::ApplicationHelper

  def successful_invoices
    Invoice.joins(:transactions).where(transactions: {result: 'success'})
  end

  def invoice_total(id)
    Invoice.find(id).invoice_items.reduce {|sum, invoice_item| invoice_item.unit_price * invoice_item.quantity}
  end

end
