# Controller to show and destroy UniUpdatesBatches
class UniUpdatesBatchesController < ApplicationController
  load_and_authorize_resource

  def show
    @uni_updates_batch = UniUpdatesBatch.find_by(batch_id: params[:id])
  end

  def destroy
    @uni_updates_batch = UniUpdatesBatch.find_by(batch_id: params[:id])
    WebformsMailer.batch_delete_email(@uni_updates_batch).deliver_now
    @uni_updates_batch.destroy
    flash[:notice] = 'Batch erased!'
    redirect_to root_path
  end
end
