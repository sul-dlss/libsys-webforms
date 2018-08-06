# Controller for Edi Lines
class EdiLinsController < ApplicationController
  def allow_nobib
    @edi_lin = EdiLin.all
    respond_to do |format|
      format.js # modal window: allow_nobib.js.erb
    end
  end

  def update
    @message = EdiLin.make_updates(params[:vendors], params[:invoice_number], params[:invoice_line_number])
    flash[@message[0].to_sym] = @message[1]

    redirect_to edi_invoices_menu_path
  end
end
