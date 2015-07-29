class Api::V1::CustomersController < Api::V1::ApplicationController

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find(params[:id])
  end

  def random
    respond_with Customer.all.sample
  end

  def find
    render json: Customer.find_by(find_params)
  end

  def find_all
    render json: Customer.where(find_params)
  end

  def invoices
    render json: find_customer.invoices
  end

  def transactions
    render json: find_customer.transactions
  end

  private

  def find_customer
    Customer.find_by(id: params[:customer_id])
  end

  def find_params
    params.permit(:first_name, :last_name, :created_at, :updated_at)
  end
end
