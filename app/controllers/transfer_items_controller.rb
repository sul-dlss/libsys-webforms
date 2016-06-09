# Controller for the withdrawal of items from the database
class TransferItemsController < ApplicationController
  load_and_authorize_resource
  def new
    @transfer_item = TransferItem.new
  end

  def create
    transfer_item = TransferItem.new(params[:transfer_item])
    if transfer_item.valid?
      array_of_item_ids = transfer_item.parse_uploaded_file
      @uni_updates_batch = UniUpdatesBatch.create_transfer_item_batch(params)
      UniUpdates.create_item_type_updates(array_of_item_ids, @uni_updates_batch)
      redirect_valid
    else
      render action: 'new'
      flash[:error] = 'Check that all fields are entered correctly'
    end
  end

  def redirect_valid
    flash[:notice] = 'Batch uploaded!'
    redirect_to @uni_updates_batch
  end
end
