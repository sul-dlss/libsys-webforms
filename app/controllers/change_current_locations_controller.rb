# Controller for the batch update for current locations
class ChangeCurrentLocationsController < ApplicationController
  load_and_authorize_resource
  def new
    @change_current_location = ChangeCurrentLocation.new
  end

  # rubocop:disable Metrics/MethodLength
  def create
    @change_current_location = ChangeCurrentLocation.new(params[:change_current_location])
    if @change_current_location.valid?
      array_of_item_ids = @change_current_location.parse_uploaded_file
      @uni_updates_batch = UniUpdatesBatch.create_current_location_batch(params, array_of_item_ids.count)
      UniUpdates.create_for_batch(array_of_item_ids, @uni_updates_batch)
      WebformsMailer.batch_upload_email(@uni_updates_batch).deliver_now
      flash[:notice] = 'Batch uploaded!'
      redirect_to @uni_updates_batch
    else
      render action: 'new'
    end
  end
  # rubocop:enable Metrics/MethodLength
end
