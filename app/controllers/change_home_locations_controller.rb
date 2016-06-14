# Controller for the change home location form
class ChangeHomeLocationsController < ApplicationController
  load_and_authorize_resource
  def new
    @change_home_location = ChangeHomeLocation.new
  end

  def create
    @change_home_location = ChangeHomeLocation.new(params[:change_home_location])
    if @change_home_location.valid?
      array_of_item_ids = @change_home_location.parse_uploaded_file
      @uni_updates_batch = UniUpdatesBatch.create_home_location_batch(params)
      UniUpdates.create_for_batch(array_of_item_ids, @uni_updates_batch)
      flash[:notice] = 'Batch uploaded!'
      redirect_to @uni_updates_batch
    else
      render action: 'new'
    end
  end
end
