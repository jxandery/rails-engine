class Api::V1::CustomersController < ApplicationController

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find(params[:id])
  end

  def random
    respond_with Customer.all.sample
  end

  def find
    respond_with Customer.find_by(find_params)
  end

  def find_all
    respond_with Customer.where(find_params)
  end

  private

  def find_params
    params.permit(:first_name, :last_name, :created_at, :updated_at)
  end
end
