class Api::V1::InvoiceItemsController < ApplicationController

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
    respond_with InvoiceItems.find_by(find_params)
  end

  def find_all
    respond_with InvoiceItems.where(find_params)
  end

  private

  def find_params
    params.permit(:item_id, :invoice_id, :quantity, :unit_price :created_at, :updated_at)
  end
end
