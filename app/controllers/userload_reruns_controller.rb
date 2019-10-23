# Controller for the Userload rerun form
class UserloadRerunsController < ApplicationController
  load_and_authorize_resource

  # GET /userload_reruns/new
  def new
    @userload_rerun = UserloadRerun.new
  end

  # POST /userload_reruns
  # POST /userload_reruns.json
  def create
    @userload_rerun = UserloadRerun.new(userload_rerun_params)

    if @userload_rerun.valid?
      # write date to file to Symphony mount [/symphony] on libsys-webforms-dev
      @userload_rerun.write_date
      flash[:success] = 'Userload Rerun requested!'
      redirect_to root_path
    else
      flash[:warning] = 'Check that all form fields are entered!'
      render action: 'new'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def userload_rerun_params
    params.require(:userload_rerun).permit(:rerun_date)
  end
end
