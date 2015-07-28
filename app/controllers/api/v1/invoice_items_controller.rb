class Api::V1::InvoiceItemsController < Api::V1::ApplicationController

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find(params[:id])
  end

  def random
    respond_with InvoiceItems.all.sample
  end

  def find
    render json: InvoiceItems.find_by(find_params)
  end

  def find_all
    render json: InvoiceItems.where(find_params)
  end

  private

  def find_params
    params.permit(:item_id, :invoice_id, :quantity, :unit_price :created_at, :updated_at)
  end
end
