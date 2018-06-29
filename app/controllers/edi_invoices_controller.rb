# Controller for EdiInvoice management
class EdiInvoicesController < ApplicationController
  load_and_authorize_resource
  has_scope :vendfilter

  def menu; end

  def index
    @edi_invoice = apply_scopes(EdiInvoice).all
  end

  def invoice_exclude
    @edi_invoice = apply_scopes(EdiInvoice).all
    respond_to do |format|
      format.js # invoice_exclude.js.erb
    end
  end
end
