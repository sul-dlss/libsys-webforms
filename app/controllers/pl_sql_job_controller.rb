# Controller class to execute PL/SQL jobs
class PlSqlJobController < ApplicationController
  def create
    begin
      plsql.instance_eval(create_params[:command])
    rescue StandardError => error
      flash[:error] = "Error - cannot run #{create_params[:command]}: #{error}"
    else
      flash[:success] = create_params[:confirm].to_s
    end

    redirect_to root_path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def create_params
    params.permit(:command, :confirm)
  end
end
