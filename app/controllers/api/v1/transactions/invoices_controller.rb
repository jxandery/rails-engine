class Api::V1::Transactions::InvoicesController < Api::V1::ApplicationController

  def show
    render json: find_transaction.invoice
  end
end
