# Controller to show and destroy UniUpdatesBatches
class UniUpdatesBatchesController < ApplicationController
  def show
    @uni_updates_batch = UniUpdatesBatch.find_by(batch_id: params[:id])
  end

  def destroy
    UniUpdatesBatch.find_by(batch_id: params[:id]).destroy
    flash[:notice] = 'Batch erased!'
    redirect_to root_path
  end
end
