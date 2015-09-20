class Api::V1::Merchants::TotalRevenuesController < Api::V1::ApplicationController

  def show
    render json: {"revenue" => revenue(invoices_by_date).to_s}.to_json
  end
end
