module Api::V1::ApplicationHelper

  def successful_invoices
    # may need to change this method
    # currently invoice has many transactions
    # those transactions can be both success and failed
    #
    # as the method is currently defined, if any of the transactions are successful,
    # then the invoice is listed as successful
    # may want to consider changing/writing the test and method to if any transactions.result == 'failed'
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
