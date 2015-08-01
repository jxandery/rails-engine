module Api::V1::ApplicationHelper

  def successful_invoices
    Invoice.joins(:transactions).where(transactions: {result: 'success'})
  end

  def invoice_total(invoice)
    invoice.invoice_items.map {|invoice_item| invoice_item.unit_price * invoice_item.quantity}.reduce(:+)
  end

  def successful_merchant_invoices
    successful_invoices.where(invoices: {merchant_id: params[:merchant_id]})
  end

  def customer_invoices
    successful_merchant_invoices.group_by {|invoice| invoice.customer_id}
  end
end
