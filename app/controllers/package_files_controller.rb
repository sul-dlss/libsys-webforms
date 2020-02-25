##
# Package Files controller for eloader
##
class PackageFilesController < ApplicationController
  load_and_authorize_resource

  def queue
    @files = PackageFile.files_to_load
  end

  def completed
    @package = Package.find_by(package_params)
    @files = PackageFile.all.where(package_id: package_params[:package_id], status_load: 'DONE')
                        .order(date_of_action: :desc)
  end

  private

  def package_params
    params.permit(:package_id)
  end
end
