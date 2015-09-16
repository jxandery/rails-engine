class Api::V1::InvoiceItems::ItemsController < Api::V1::ApplicationController

  def show
    render json: find_invoice_item.item
  end
end
