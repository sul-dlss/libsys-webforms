# Controller to handle confirmation pages for batch uploads
class ConfirmationPagesController < ApplicationController
  def confirm_batch_upload
    @uni_updates_batch = UniUpdatesBatch.find_by(batch_id: session[:batch_id])
  end

  def confirm_batch_deletion
    UniUpdatesBatch.destroy_all(batch_id: session[:batch_id])
    flash[:notice] = 'Batch erased!'
    redirect_to root_path
  end
end
