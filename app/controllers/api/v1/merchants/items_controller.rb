class Api::V1::Merchants::ItemsController < Api::V1::ApplicationController

  def index
    render json: find_merchant.items
  end
end
