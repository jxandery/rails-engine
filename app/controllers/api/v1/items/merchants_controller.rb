class Api::V1::Items::MerchantsController < Api::V1::ApplicationController

  def show
    render json: find_item.merchant
  end
end
