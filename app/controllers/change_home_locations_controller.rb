# Controller for the change home location form
class ChangeHomeLocationsController < ApplicationController
  load_and_authorize_resource
  def new
    @change_home_location = ChangeHomeLocation.new
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def create
    @change_home_location = ChangeHomeLocation.new(params[:change_home_location])
    if @change_home_location.valid?
      array_of_item_ids = @change_home_location.parse_uploaded_file
      UniUpdates.where(item_id: array_of_item_ids)
                .update_all({ curr_lib: @change_home_location.current_library,
                              new_homeloc: @change_home_location.new_home_location,
                              new_itype: @change_home_location.new_item_type,
                              new_curloc: @change_home_location.new_current_location }
                .reject { |_k, v| v.blank? })
      flash[:notice] = 'Batch uploaded!'
      redirect_to root_url
    else
      render action: 'new'
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
