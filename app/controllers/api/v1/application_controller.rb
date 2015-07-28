class Api::V1::ApplicationController < ApplicationController
  respond_to :json, :xml
  before_action :authenticate, except: [:index, :show]

  def authenticate
    authenticate_or_request_with_http_basic('Please authenticate to use API') do |email, password|
      user = User.find_by(email: email)

      return true if user && user.authenticate(password)
    end
  end
end
