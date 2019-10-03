# Controller for the ILLiad User Export
class IlliadUserExportsController < ApplicationController
  def new
    @illiad_user_export = IlliadUserExport.new
  end

  def create
    @illiad_user_export = IlliadUserExport.new(illiad_params)

    if @illiad_user_export.valid?
      # write sunet id file to Symphony mount [/symphony] on libsys-webforms
      @illiad_user_export.write_ids
      flash[:success] = 'ILLiad User Export requested!'
      redirect_to root_path
    else
      flash[:warning] = 'Check that all form fields are entered!'
      render action: 'new'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def illiad_params
    params.require(:illiad_user_export).permit(:sunet_ids)
  end
end
