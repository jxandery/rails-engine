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
    respond_with Item.find_by(find_params)
  end

  def find_all
    respond_with Item.where(find_params)
  end

  private

  def find_params
    params.permit(:name, :description, :unit_price, :merchant_id :created_at, :updated_at)
  end
end
