class Api::V1::ItemsController < Api::V1::ApplicationController

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end

  def random
    respond_with Item.all.sample
  end

  def find
    render json: Item.find_by(find_params)
  end

  def find_all
    render json: Item.where(find_params)
  end

  def invoice_items
    render json: Item.find(params[:item_id]).invoice_items
  end

  def merchant
    render json: Item.find(params[:item_id]).merchant
  end
  private

  def find_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
