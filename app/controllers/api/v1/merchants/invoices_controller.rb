class Api::V1::Merchants::InvoicesController < Api::V1::ApplicationController

  def index
    render json: find_merchant.invoices
  end
end
