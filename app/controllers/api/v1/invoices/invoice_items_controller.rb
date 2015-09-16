class Api::V1::Invoices::InvoiceItemsController < Api::V1::ApplicationController

  def index
    render json: find_invoice.invoice_items
  end
end
