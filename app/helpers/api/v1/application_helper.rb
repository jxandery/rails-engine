module Api::V1::ApplicationHelper

  def successful_invoices
    Invoice.joins(:transactions).where(transactions: {result: 'success'})
  end
end
