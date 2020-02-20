# Controller for Edi Lines
class EdiLinsController < ApplicationController
  load_and_authorize_resource

  def allow_nobib
    @edi_lin = EdiLin.all
    respond_to do |format|
      format.js # modal window: allow_nobib.js.erb
    end
  end

  def fix_duplicate_barcode
    respond_to do |format|
      format.js # modal window: fix_duplicate_barcode.js.erb
    end
  end

  def show
    @edi_lin = EdiLin.where(barcode_num: params[:barcode_num])
  end

  def index
    @edi_lin = EdiLin.where(barcode_num: params[:barcode_num])
    if @edi_lin.size.zero?
      redirect_to(edi_invoices_menu_path, flash: { warning: "Barcode #{params[:barcode_num]} does not exist "\
                                                            'as a barcode in the EDI_LIN table.' })
    elsif @edi_lin.size < 2
      redirect_to(edi_invoices_menu_path, flash: { warning: "Barcode #{params[:barcode_num]} is not a duplicate. "\
                                                            'It only appears once in the EDI_LIN table.' })
    else
      redirect_to "/edi_lins/show/#{params[:barcode_num]}"
    end
  end

  def edit
    @edi_lin = EdiLin.where(vend_id: params[:vend_id],
                            doc_num: params[:doc_num],
                            edi_lin_num: params[:edi_lin_num],
                            edi_sublin_count: params[:edi_sublin_count],
                            barcode_num: params[:barcode_num])
  end

  def update_edi_lin
    @edi_lin_result = EdiLin.update_edi_lin(params[:vendors], params[:invoice_number], params[:invoice_line_number])
    flash[@edi_lin_result[0].to_sym] = @edi_lin_result[1]

    redirect_to edi_invoices_menu_path
  end

  def update_barcode
    @barcode_result = EdiLin.update_barcode(params[:vend_id],
                                            params[:doc_num],
                                            params[:edi_lin_num],
                                            params[:edi_sublin_count],
                                            params[:old_barcode],
                                            params[:new_barcode])
    flash[@barcode_result[0].to_sym] = @barcode_result[1]
    redirect_to edi_invoices_menu_path
  end
end
