# Controller for EdiInvoice management
class EdiInvoicesController < ApplicationController
  def index; end

  def invoice_exclude
    # @EdiSomeModel = EdiSomeModel.new
    respond_to do |format|
      format.js # invoice_exclude.js.erb
    end
  end
end
