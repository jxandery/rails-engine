class Api::V1::InvoiceItems::InvoicesController < Api::V1::ApplicationController

  def show
    render json: find_invoice_item.invoice
  end
end
