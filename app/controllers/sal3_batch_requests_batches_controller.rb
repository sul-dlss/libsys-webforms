# Controller to handle the SAL3 Batch Requests landing page
class Sal3BatchRequestsBatchesController < ApplicationController
  load_and_authorize_resource
  has_scope :pullmon
  has_scope :pulltues
  has_scope :pullwed
  has_scope :pullthurs
  has_scope :pullfri
  has_scope :statusfilter

  def index
    @sal3_batch_requests_batches = apply_scopes(Sal3BatchRequestsBatch).all
  end

  def show
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.find(params[:id])
  end

  def new
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.new
    @current_user_name = current_user_name
  end

  def create
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.new(sal3_batch_requests_batch_params)
    @sal3_batch_requests_batch.bc_file = sal3_batch_requests_batch_params[:bc_file]
    if @sal3_batch_requests_batch.save
      array_of_item_ids = @sal3_batch_requests_batch.parse_bc_file
      begin
        Sal3BatchRequestBcs.create_sal3_request(array_of_item_ids, bcs_params(@sal3_batch_requests_batch))
      rescue ActiveRecord::RecordNotUnique
        flash[:warning] = 'Batch with unique barcodes already requested.'
      end
      WebformsMailer.sal3_batch_email(@sal3_batch_requests_batch).deliver_now
      flash[:success] = 'Batch requested!'
      redirect_to root_path
    else
      render action: 'new'
      flash[:warning] = 'Check that all form fields are entered!'
    end
  end

  def edit
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.find(params[:id])
  end

  def update
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.find(params[:id])
    if @sal3_batch_requests_batch.update(sal3_batch_requests_batch_params)
      flash[:success] = 'Batch updated!'
      redirect_to sal3_batch_requests_batches_path
    else
      render action: 'edit'
    end
  end

  def download
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.find(params[:id])
    begin
      send_file @sal3_batch_requests_batch.bc_file.current_path, type: 'text/plain', disposition: 'attachment'
    rescue StandardError
      flash[:warning] = 'No barcode file exists for this batch.'
      redirect_to root_path
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
      priority: sal3_batch.priority
    }
  end
end
