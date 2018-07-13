# Controller for EdiInvLine editing and updating
class EdiInvLineController < ApplicationController
  def edit
    @edi_inv_line = EdiInvLine.find(params[:id])
  end

  def update
    @edi_inv_line = EdiInvLine.find(params[:id])
    if @edi_inv_line.update(edi_inv_line_params)
      params_updated = []
      edi_inv_line_params.each do |param|
        params_updated << param[1]
      end
      flash[:success] = "Invoice updated! Fund name: #{params_updated[0]}, PO: #{params_updated[1]}"
      redirect_to edi_invoices_menu_path
    else
      render action: 'edit'
    end
  end

  def edi_inv_line_params
    params.require(:edi_inv_line).permit!
  end
end
