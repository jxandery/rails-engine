class Api::V1::Invoices::CustomersController < Api::V1::ApplicationController

  def show
    render json: find_invoice.customer
  end
end
