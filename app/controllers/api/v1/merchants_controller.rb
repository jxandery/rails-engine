class Api::V1::MerchantsController < Api::V1::ApplicationController

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find(params[:id])
  end

  def random
    respond_with Merchant.all.sample
  end

  def find
    render json: Merchant.find_by(find_params)
  end

  def find_all
    render json: Merchant.where(find_params)
  end

  def items
    render json: Merchant.find(params[:merchant_id]).items
  end

  def invoices
    render json: Merchant.find(params[:merchant_id]).invoices
  end

  def revenue
    x = successful_merchant_invoices.map {|invoice| invoice_total(invoice)}.reduce(:+)
    render json: {:revenue => "#{x}"}.to_json
  end

  def favorite_customer
    customer_id = customer_invoices.max_by {|customer_id| customer_id.count}.first
    render json: Customer.find(customer_id)
  end

  def customers_with_pending_invoices
    require "pry"; binding.pry
    successful_merchant_invoices
  end

  private

  def find_params
    params.permit(:name)
  end
end
