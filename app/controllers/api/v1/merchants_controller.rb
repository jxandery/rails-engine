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
    successful_merchant_invoices = successful_invoices.where(invoices: {merchant_id: params[:merchant_id]})
    render json: successful_merchant_invoices.reduce {|sum, invoice| invoice_total(invoice.id)}
  end

  private

  def find_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
