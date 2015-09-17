class Api::V1::Merchants::TotalRevenuesController < Api::V1::ApplicationController

  def show
    render json: {revenue: "#{revenue(find_merchant.invoices)}"}.to_json
  end
end
