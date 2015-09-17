class Api::V1::Merchants::RevenuesController < Api::V1::ApplicationController

  def show


    #grab all the merchant
    #find the successful invoices
    #find the invoices with the correct date
    #return the revenue total
    #revenue(invoices_by_date)
    render json: {"revenue" => revenue(invoices_by_date).to_s}.to_json
  end

  def index
  end
end
