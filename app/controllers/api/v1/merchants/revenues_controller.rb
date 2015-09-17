class Api::V1::Merchants::RevenuesController < Api::V1::ApplicationController

  def show
    render json: {"revenue" => revenue(invoices_by_date).to_s}.to_json
  end

  def index
    render json: {"total_revenue" => all_invoices_by_date.to_s}.to_json
  end
end
