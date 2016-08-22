# Controller for the withdrawal of items from the database
class WithdrawItemsController < ApplicationController
  load_and_authorize_resource
  def new
    @withdraw_item = WithdrawItem.new
  end

  # rubocop:disable Metrics/MethodLength
  def create
    @withdraw_item = WithdrawItem.new(params[:withdraw_item])
    if @withdraw_item.valid?
      array_of_item_ids = @withdraw_item.parse_uploaded_file
      @uni_updates_batch = UniUpdatesBatch.create_withdraw_item_batch(params, array_of_item_ids.count)
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
