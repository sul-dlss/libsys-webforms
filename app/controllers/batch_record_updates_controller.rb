# Controller to handle the Batch Record Updates landing page
class BatchRecordUpdatesController < ApplicationController
  load_and_authorize_resource

  def index; end

  def errors_for_batch
    @uni_updates_batch = UniUpdatesBatch.where(batch_id: params[:batch_number])
    @uni_updates_errors = UniUpdatesErrors.where(batch: params[:batch_number])
  end

  def errors_for_mhld
    @uni_updates_batch = UniUpdatesBatch.where(batch_id: params[:batch_number])
    @uni_mhld_errors = UniUpdMhldError.where(batch_id: params[:batch_number])
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
    @batches_complete = UniUpdatesBatch.joins(:uni_updates).where('uni_updates_batch.pending is null').distinct
  end
end
