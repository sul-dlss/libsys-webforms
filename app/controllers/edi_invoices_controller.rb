# Controller for EdiInvoice management
class EdiInvoicesController < ApplicationController
  load_and_authorize_resource
  has_scope :vendfilter

  def menu; end

  def index
    @edi_invoice = apply_scopes(EdiInvoice).all
  end

  def change_invoice_line
    @edi_inv_line = EdiInvLine.where("todo = 'CreOrd'")
    respond_to do |format|
      format.js # modal window: chane_invoice_line.js.erb
    end
  end

  def invoice_exclude
    @edi_invoice = EdiInvoice.all
    respond_to do |format|
      format.js # modal window: invoice_exclude.js.erb
    end
  end
end
