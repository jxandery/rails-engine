class Api::V1::Invoices::TransactionsController < Api::V1::ApplicationController

  def index
    render json: find_invoice.transactions
  end
end
