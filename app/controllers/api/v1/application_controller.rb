class Api::V1::ApplicationController < ApplicationController
  include Api::V1::ApplicationHelper

  respond_to :json, :xml
  #before_action :authenticate, except: [:index, :show]

  def authenticate
    authenticate_or_request_with_http_basic('Please authenticate to use API') do |email, password|
      user = User.find_by(email: email)

      return true if user && user.authenticate(password)
    end
  end

  def find_customer
    Customer.find_by(id: params[:customer_id])
  end
  helper_method :find_customer

end
