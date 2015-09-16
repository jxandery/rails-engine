class Api::V1::Customers::InvoicesController < Api::V1::ApplicationController

  def index
    render json: find_customer.invoices
  end

  private

  def find_customer
    Customer.find_by(id: params[:customer_id])
  end


end
