class Api::V1::Merchants::MostItemsController < Api::V1::ApplicationController

  def index
    render json: most_items
  end
end
