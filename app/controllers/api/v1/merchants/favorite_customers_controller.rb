class Api::V1::Merchants::FavoriteCustomersController < Api::V1::ApplicationController

  def show
    render json: Customer.find(favorite_customer.max[1])
  end
end
