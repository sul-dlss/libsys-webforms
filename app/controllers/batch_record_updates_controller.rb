# Controller to handle the Batch Record Updates landing page
class BatchRecordUpdatesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def errors_for_batch
    @batch = UniUpdatesErrors.where("BATCH = #{params[:batch_number]}")
  end
end
