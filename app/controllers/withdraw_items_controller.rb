# Controller for the withdrawal of items from the database
class WithdrawItemsController < ApplicationController
  load_and_authorize_resource
  def new
    @withdraw_item = WithdrawItem.new
  end

  def create
    @withdraw_item = WithdrawItem.new(params[:withdraw_item])
    if @withdraw_item.valid?
      array_of_item_ids = @withdraw_item.parse_uploaded_file
      filtered_item_ids = UniUpdates.filter_duplicates(array_of_item_ids)
      uniques = filtered_item_ids[0]
      duplicates = filtered_item_ids[1].join(' ')
      @uni_updates_batch = UniUpdatesBatch.create_withdraw_item_batch(params, uniques.count)
      UniUpdates.create_for_batch(uniques, @uni_updates_batch)
      WebformsMailer.batch_upload_email(@uni_updates_batch, duplicates).deliver_now
      flash[:notice] = 'Batch uploaded!'
      redirect_to uni_updates_batch_path(@uni_updates_batch, duplicates: duplicates)
    else
      render action: 'new'
    end
  end
end
