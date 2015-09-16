class Api::V1::Merchants::RevenuesController < Api::V1::ApplicationController

  def show
    render json: {revenue: "#{revenue}"}.to_json
  end
end
