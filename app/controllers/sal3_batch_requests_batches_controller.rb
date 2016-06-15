# Controller to handle the SAL3 Batch Requests landing page
class Sal3BatchRequestsBatchesController < ApplicationController
  def new
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.new
    @current_user_name = current_user_name
  end

  def create
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.new(batch_params)
    if @sal3_batch_requests_batch.save
      array_of_item_ids = @sal3_batch_requests_batch.parse_bc_file
      Sal3BatchRequestBcs.create_sal3_batch(array_of_item_ids, bcs_params(@sal3_batch_requests_batch))
      flash[:notice] = 'Batch requested!'
      redirect_to root_path
    else
      render action: 'new'
      flash[:warning] = 'Check that all form fields are entered!'
    end
  end

  def batch_params
    params.require(:sal3_batch_requests_batch).permit!
  end

  def bcs_params(batch_params)
    {
      batch_id: batch_params.batch_id,
      pending: batch_params.pending,
      load_date: batch_params.load_date,
      priority: batch_params.priority,
      run_date: batch_params.load_date,
      completed_date: batch_params.last_action_date
    }
  end
end
