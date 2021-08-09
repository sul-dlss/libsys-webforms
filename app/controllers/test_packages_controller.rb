##
# Package controller for eloader to query records on LTRXDEV2
##
class TestPackagesController < ApplicationController
  load_and_authorize_resource param_method: :test_package_params

  def show
    redirect_to new_package_path(package_id: test_package_params)
  end

  def copy_form; end

  private

  def test_package_params
    params.require(:package_id)
  end
end
