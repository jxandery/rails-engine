class Api::V1::Merchants::MostRevenuesController < Api::V1::ApplicationController

  def index
    render json: most_revenue
  end
end
