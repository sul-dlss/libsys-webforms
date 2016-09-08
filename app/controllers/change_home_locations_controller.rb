# Controller for the change home location form
class ChangeHomeLocationsController < ApplicationController
  load_and_authorize_resource
  def new
    @change_home_location = ChangeHomeLocation.new
  end

  # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
  def create
    @change_home_location = ChangeHomeLocation.new(params[:change_home_location])
    if @change_home_location.valid?
      array_of_item_ids = @change_home_location.parse_uploaded_file
      filtered_item_ids = UniUpdates.filter_duplicates(array_of_item_ids)
      uniques = filtered_item_ids[0]
      duplicates = filtered_item_ids[1].join(' ')
      @uni_updates_batch = UniUpdatesBatch.create_home_location_batch(params, uniques.count)
      UniUpdates.create_for_batch(uniques, @uni_updates_batch)
      WebformsMailer.batch_upload_email(@uni_updates_batch, duplicates).deliver_now
      flash[:notice] = 'Batch uploaded!'
      redirect_to uni_updates_batch_path(@uni_updates_batch, duplicates: duplicates)
    else
      render action: 'new'
    end
  end
  # rubocop:enable Metrics/MethodLength,Metrics/AbcSize
end
