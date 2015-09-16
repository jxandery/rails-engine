class Api::V1::Merchants::CustomersWithPendingInvoicesController < Api::V1::ApplicationController

  def index
    render json: customers_with_pending_invoices
  end
end
