# Controller for the ILLiad User Export
class IlliadUserExportsController < ApplicationController
  load_and_authorize_resource

  def new
    @illiad_user_export = IlliadUserExport.new
  end

  def create
    @illiad_user_export = IlliadUserExport.new(illiad_user_export_params)

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

  def illiad_user_export_params
    params.require(:illiad_user_export).permit(:sunet_ids)
  end
end
