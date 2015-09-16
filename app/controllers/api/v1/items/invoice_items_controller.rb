class Api::V1::Items::InvoiceItemsController < Api::V1::ApplicationController

  def index
    render json: find_item.invoice_items
  end
end
