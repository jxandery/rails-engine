class Api::V1::Merchants::TotalRevenuesController < Api::V1::ApplicationController

  def show
    require "pry"; binding.pry
    render json: invoices_by_date
  end
end
