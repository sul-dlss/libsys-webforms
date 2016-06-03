# Controller for the change_item_type form
class ChangeItemTypesController < ApplicationController
  load_and_authorize_resource
  def new
    @change_item_type = ChangeItemType.new
  end

  # rubocop:disable Metrics/MethodLength
  def create
    change_item_type = ChangeItemType.new(params[:change_item_type])
    if change_item_type.valid?
      array_of_item_ids = change_item_type.parse_uploaded_file
      uni_updates_batch = UniUpdatesBatch.create_item_type_batch(params)
      session[:batch_id] = uni_updates_batch.batch_id
      UniUpdates.create_item_type_updates(array_of_item_ids, uni_updates_batch)
      flash[:notice] = 'Batch updated!'
      redirect_to confirm_batch_upload_path
    else
      render action: 'new'
    end
  end
  # rubocop:enable Metrics/MethodLength
end
