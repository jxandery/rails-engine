class Api::V1::InvoiceItemsController < Api::V1::ApplicationController

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find(params[:id])
  end

  def random
    respond_with InvoiceItem.all.sample
  end

  def find
    render json: InvoiceItem.find_by(find_params)
  end

  def find_all
    render json: InvoiceItem.where(find_params)
  end

  def invoice
    render json: InvoiceItem.find(params[:invoice_item_id]).invoice
  end

  def item
    render json: InvoiceItem.find(params[:invoice_item_id]).item
  end

  private

  def find_params
    params.permit(:item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
