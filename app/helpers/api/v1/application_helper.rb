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

  def find_customer
    Customer.find_by(id: params[:customer_id])
  end

  def successful_customer_invoices
    invoices = successful_invoices.where(invoices: {customer_id: params[:customer_id]})
    invoices.group_by {|x| x.merchant_id}.first.last.first.merchant_id
  end

  def find_invoice_item
    InvoiceItem.find_by(id: params[:invoice_item_id])
  end

  def find_invoice
    Invoice.find_by(id: params[:invoice_id])
  end

  def find_item
    Item.find_by(id: params[:item_id])
  end

  def find_merchant
    Merchant.find_by(id: params[:merchant_id])
  end

  def revenue
    successful_merchant_invoices.map {|invoice| invoice_total(invoice)}.reduce(:+)
  end

  def favorite_customer
    customers = {}
    customer_invoices.each do |customer_id, invoices|
      customers[invoices.count] = customer_id
    end
    customers
  end

  def customers_with_pending_invoices
    (Invoice.all - successful_merchant_invoices).map do |invoice|
      Customer.find(invoice.customer_id)
    end
  end
end

