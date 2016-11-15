# Controller to handle the SAL3 Batch Requests landing page
class Sal3BatchRequestsBatchesController < ApplicationController
  load_and_authorize_resource
  def index
    @sal3_batch_requests_batches = Sal3BatchRequestsBatch.all
  end

  def new
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.new
    @current_user_name = current_user_name
  end

  def create
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.new(sal3_batch_requests_batch_params)
    if @sal3_batch_requests_batch.save
      array_of_item_ids = @sal3_batch_requests_batch.parse_bc_file
      Sal3BatchRequestBcs.create_sal3_request(array_of_item_ids, bcs_params(@sal3_batch_requests_batch))
      flash[:success] = 'Batch requested!'
      redirect_to root_path
    else
      render action: 'new'
      flash[:warning] = 'Check that all form fields are entered!'
    end
  end

  def sal3_batch_requests_batch_params
    params.require(:sal3_batch_requests_batch).permit!
  end

  def bcs_params(sal3_batch)
    {
      batch_id: sal3_batch.batch_id,
      pending: sal3_batch.pending,
      load_date: sal3_batch.load_date,
      priority: sal3_batch.priority,
      run_date: sal3_batch.load_date,
      completed_date: sal3_batch.last_action_date
    }
  end
end
