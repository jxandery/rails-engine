module Api::V1::ApplicationHelper

  def find_customer
    Customer.find_by(id: params[:customer_id])
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

  def find_transaction
    Transaction.find_by(id: params[:transaction_id])
  end

  def successful_invoices(invoices)
    invoices.joins(:transactions).where(transactions: {result: 'success'})
  end

  def invoice_total(invoice)
    invoice.invoice_items.map {|invoice_item| invoice_item.unit_price * invoice_item.quantity}.reduce(:+)
  end

  def successful_merchant_invoices
    successful_invoices(find_merchant.invoices)
  end

  def merchant_invoices
    successful_invoices(find_merchant.invoices)
  end

  def successful_customer_invoices
    i = successful_invoices(find_customer.invoices)
    i.group_by {|x| x.merchant_id}.first.last.first.merchant_id
  end

  def customer_invoices
    successful_merchant_invoices.group_by {|invoice| invoice.customer_id}
  end

  def revenue(invoices)
    successful_invoices(invoices).map {|invoice| invoice_total(invoice)}.reduce(:+)
  end

  def invoices_by_date
    if params[:date].nil?
      find_merchant.invoices
    else
      merchant_invoices.find_all {|invoice| invoice.created_at.to_s[0..9] == params[:date][0..9]}
    end
  end

  def all_invoices_by_date
    i = successful_invoices(Invoice.all).find_all {|invoice| invoice.created_at.to_s[0..-5] == params[:date]}
    i.map {|invoice| invoice_total(invoice)}.reduce(:+)
  end

  def favorite_customer
    customers = {}
    customer_invoices.each do |customer_id, invoices|
      customers[invoices.count] = customer_id
    end
    customers
  end

  def customers_with_pending_invoices
    successful_invoices(find_merchant.invoices).map do |invoice|
    #(Invoice.where(merchant_id: params["merchant_id"].to_i) - successful_merchant_invoices).map do |invoice|
      Customer.find(invoice.customer_id)
    end
  end

  def item_count(merchant_id)
    successful_invoices(Merchant.find(merchant_id).invoices).joins(:invoice_items).sum(:quantity)
  end

  def most_items
    merchants = Merchant.all.sort_by {|merch| item_count(merch.id)}.reverse!
    merchants.first(params["quantity"].to_i).to_json
  end

  def top_merchants
    Merchant.all.map do |merch|
      [revenue(merch.invoices), merch]
    end.sort.reverse!
  end

  def most_revenue
    top_merchants.map do |merch|
      merch[1]
    end.first(params["quantity"].to_i)
  end
end

