class Api::V1::Customers::InvoicesController < Api::V1::ApplicationController

  def index
    render json: find_customer.invoices
  end
end
