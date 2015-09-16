class Api::V1::InvoicesController < Api::V1::ApplicationController

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find(params[:id])
  end

  def random
    respond_with Invoice.all.sample
  end

  def find
    render json: Invoice.find_by(find_params)
  end

  def find_all
    render json: Invoice.where(find_params)
  end

  private

  def find_params
    params.permit(:customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
