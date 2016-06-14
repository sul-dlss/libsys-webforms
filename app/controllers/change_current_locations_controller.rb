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
      @uni_updates_batch = UniUpdatesBatch.create_current_location_batch(params)
      UniUpdates.create_for_batch(array_of_item_ids, @uni_updates_batch)
      flash[:notice] = 'Batch uploaded!'
      redirect_to @uni_updates_batch
    else
      render action: 'new'
    end
  end
end
