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
    render :json Merchant.find_by(find_params)
  end

  def find_all
    render :json Merchant.where(find_params)
  end

  private

  def find_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
