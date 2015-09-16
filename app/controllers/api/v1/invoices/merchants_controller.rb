class Api::V1::Invoices::MerchantsController < Api::V1::ApplicationController

  def show
    render json: find_invoice.merchant
  end
end
