# Controller for the batch update for current locations
class ChangeCurrentLocationsController < ApplicationController
  load_and_authorize_resource
  def new
    @change_current_location = ChangeCurrentLocation.new
  end

  def create
    @change_current_location = ChangeCurrentLocation.new(params[:change_current_location])
    if @change_current_location.valid?
      array_of_item_ids = @change_current_location.parse_uploaded_file
      UniUpdates.where(item_id: array_of_item_ids).update_all(curr_lib: @change_current_location.current_library,
                                                              new_curloc: @change_current_location.new_current_location)
      flash[:notice] = 'Batch updated!'
      redirect_to root_url
    else
      render action: 'new'
    end
  end
end
