# Controller class to execute PL/SQL jobs
class PlSqlJobController < ApplicationController
  def create
    begin
      plsql.instance_eval(create_params[:command])
    rescue StandardError => e
      flash[:error] = "Error - cannot run #{create_params[:command]}: #{e}"
    else
      flash[:success] = create_params[:confirm].to_s
    end

    redirect_to root_path
  end

  def package_file_transfer
    begin
      plsql.instance_eval(create_params[:command])
    rescue StandardError => e
      flash[:error] = "Error - cannot run #{create_params[:command]}: #{e}"
    else
      flash[:success] = create_params[:confirm].to_s
    end
    redirect_to list_transfer_logs_packages_path
  end

  def package_test_load
    begin
      plsql.instance_eval(create_params[:command])
    rescue StandardError => e
      flash[:error] = "Error - cannot run #{create_params[:command]}: #{e}"
    else
      flash[:success] = create_params[:confirm].to_s
    end
    redirect_to run_tests_packages_path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def create_params
    params.permit(:command, :confirm)
  end
end
