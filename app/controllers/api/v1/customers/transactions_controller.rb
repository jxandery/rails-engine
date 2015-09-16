class Api::V1::Customers::TransactionsController < Api::V1::ApplicationController

  def index
    render json: find_customer.transactions
  end
end
