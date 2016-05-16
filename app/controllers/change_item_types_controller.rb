# Controller for the change_item_type form
class ChangeItemTypesController < ApplicationController
  load_and_authorize_resource
  def new
    @change_item_type = ChangeItemType.new
  end

  def create
    @change_item_type = ChangeItemType.new(params[:change_item_type])
    if @change_item_type.valid?
      array_of_item_ids = @change_item_type.parse_uploaded_file
      UniUpdates.where(item_id: array_of_item_ids).update_all(curr_lib: @change_item_type.current_library,
                                                              new_itype: @change_item_type.new_item_type)
      flash[:notice] = 'Batch updated!'
      redirect_to root_url
    else
      render action: 'new'
    end
  end
end
