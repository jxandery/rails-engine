class Api::V1::Invoices::ItemsController < Api::V1::ApplicationController

  def index
    render json: find_invoice.items
  end
end
