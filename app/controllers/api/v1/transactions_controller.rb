class Api::V1::TransactionsController < ApplicationController

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find(params[:id])
  end

  def random
    respond_with Transaction.all.sample
  end

  def find
    respond_with Transaction.find_by(find_params)
  end

  def find_all
    respond_with Transaction.where(find_params)
  end

  private

  def find_params
    params.permit(:invoice_id, :credit_card_number, :credit_card_expiration, :result, :created_at, :updated_at)
  end
end
