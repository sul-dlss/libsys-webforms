# Controller for the change_item_type form
class ChangeItemTypesController < ApplicationController
  load_and_authorize_resource param_method: :change_item_type_params

  def new
    @change_item_type = ChangeItemType.new
  end

  def create
    @change_item_type = ChangeItemType.new(change_item_type_params)
    if @change_item_type.valid?
      array_of_item_ids = @change_item_type.parse_uploaded_file
      filtered_item_ids = UniUpdates.filter_duplicates(array_of_item_ids)
      uniques = filtered_item_ids[0]
      duplicates = filtered_item_ids[1].join(' ')
      @uni_updates_batch = UniUpdatesBatch.create_item_type_batch(params, uniques.count)
      UniUpdates.create_for_batch(uniques, @uni_updates_batch)
      WebformsMailer.batch_upload_email(@uni_updates_batch, duplicates).deliver_now
      flash[:notice] = 'Batch uploaded!'
      redirect_to uni_updates_batch_path(@uni_updates_batch, duplicates: duplicates)
    else
      render action: 'new'
    end
  end

  private

  def change_item_type_params
    params.require(:change_item_type).permit(:current_library, :new_item_type,
                                             :item_ids, :email, :comments,
                                             :load_date, :user_name, :action,
                                             :priority, :export_yn, :new_lib,
                                             :new_homeloc, :new_curloc,
                                             :check_bc_first)
  end
end
