# Controller to handle the Batch Record Updates landing page
class BatchRecordUpdatesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def errors_for_batch
    @batch = UniUpdatesErrors.where("BATCH = #{params[:batch_number]}")
  end

  def show_batches_not_complete
    query = 'select b.batch_id, min(b.batch_date), min(b.user_name),
    min(b.user_email), min(b.orig_lib), min(b.action),
    min(b.total_bcs), count(u.pending) from uni_updates_batch b,
    uni_updates u where u.batch_id = b.batch_id and b.pending is not null
    group by b.batch_id order by b.batch_id'
    @batches_not_complete = ActiveRecord::Base.connection.exec_query(query)
  end

  def show_batches_complete
    @batches_complete = UniUpdatesBatch.joins(:uni_updates).where('uni_updates_batch.pending is null').uniq
  end

  def new
    @batch_record_update = BatchRecordUpdate.new
  end

  def create
    @batch_record_update = BatchRecordUpdate.new(params[:batch_record_update])
    if @batch_record_update.valid?
      array_of_batch_ids = @batch_record_update.parse_uploaded_file
      UniUpdates.where(batch_id: array_of_batch_ids).update_all(curr_lib: @batch_record_update.current_library,
                                                                new_itype: @batch_record_update.new_item_type)
      flash[:notice] = 'Batch updated!'
      redirect_to root_url
    else
      render action: 'new'
    end
  end
end
