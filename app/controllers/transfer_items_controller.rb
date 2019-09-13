# Controller for the withdrawal of items from the database
class TransferItemsController < ApplicationController
  load_and_authorize_resource
  def new
    @transfer_item = TransferItem.new
  end

  def create
    @transfer_item = TransferItem.new(transfer_item_params)
    if @transfer_item.valid?
      array_of_item_ids = @transfer_item.parse_uploaded_file
      filtered_item_ids = UniUpdates.filter_duplicates(array_of_item_ids)
      uniques = filtered_item_ids[0]
      duplicates = filtered_item_ids[1].join(' ')
      @uni_updates_batch = UniUpdatesBatch.create_transfer_item_batch(params, uniques.count)
      UniUpdates.create_for_batch(uniques, @uni_updates_batch)
      WebformsMailer.batch_upload_email(@uni_updates_batch, duplicates).deliver_now
      flash[:notice] = 'Batch uploaded!'
      redirect_to uni_updates_batch_path(@uni_updates_batch, duplicates: duplicates)
    else
      render action: 'new'
      flash[:error] = 'Check that all fields are entered correctly'
    end
  end

  private

  def transfer_item_params
    params.require(:transfer_item).permit(:current_library, :new_library, :new_homeloc, :new_item_type, :item_ids)
  end
end
