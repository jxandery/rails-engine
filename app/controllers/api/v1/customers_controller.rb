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

  def transactions
    render json: find_customer.transactions
  end

  #customer/:id/favorite_merchant
  def favorite_merchant
    render json: Merchant.find(successful_customer_invoices)
  end


  private

  def successful_customer_invoices
    invoices = successful_invoices.where(invoices: {customer_id: params[:customer_id]})
    invoices.group_by {|x| x.merchant_id}.first.last.first.merchant_id
  end

  def find_customer
    Customer.find_by(id: params[:customer_id])
  end

  def find_params
    params.permit(:first_name, :last_name, :created_at, :updated_at)
  end
end
