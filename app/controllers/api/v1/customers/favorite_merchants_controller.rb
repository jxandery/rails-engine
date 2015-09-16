class Api::V1::Customers::FavoriteMerchantsController < Api::V1::ApplicationController

  def show
    render json: Merchant.find(successful_customer_invoices)
  end
end
