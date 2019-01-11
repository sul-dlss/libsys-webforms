##
# Package controller for eloader to query records on LTRXDEV2
##
class TestPackagesController < ApplicationController
  load_and_authorize_resource

  def show
    redirect_to new_package_path(package_id: test_package_params)
  end

  def copy_form; end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def test_package_params
    params.require(:package_id)
  end
end
