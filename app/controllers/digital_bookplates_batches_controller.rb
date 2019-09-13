# Controller to show, create, and edit digital bookplate batches
class DigitalBookplatesBatchesController < ApplicationController
  load_and_authorize_resource

  def index() end

  def queue
    @digital_bookplates_batches = DigitalBookplatesBatch.all.where(completed_date: [nil])
  end

  def completed
    @digital_bookplates_batches = DigitalBookplatesBatch.all.where.not(completed_date: [nil])
  end

  def add_batch
    @digital_bookplates_batch = DigitalBookplatesBatch.new
  end

  def delete_batch
    @digital_bookplates_batch = DigitalBookplatesBatch.new
  end

  def create
    @digital_bookplates_batch = DigitalBookplatesBatch.new(digital_bookplates_batch_params)
    if @digital_bookplates_batch.save
      copy_file(digital_bookplates_batch_params[:file_obj], @digital_bookplates_batch.batch_id)
      redirect_to queue_digital_bookplates_batches_path
      flash[:notice] = 'Batch uploaded!'
    else
      if @digital_bookplates_batch.errors.any?
        @digital_bookplates_batch.errors.full_messages.each do |msg|
          flash[:error] = msg # this only displays the first error message
        end
      end
      redirect_to new_path_redirect(digital_bookplates_batch_params)
    end
  end

  def destroy
    @digital_bookplates_batch = DigitalBookplatesBatch.find_by(batch_id: params[:id])
    if @digital_bookplates_batch[:completed_date].nil?
      delete_file(@digital_bookplates_batch.ckey_file, @digital_bookplates_batch.batch_id)
      @digital_bookplates_batch.destroy
      flash[:notice] = 'Batch deleted!'
    else
      flash[:error] = 'Batch cannot be deleted!'
    end
    redirect_to digital_bookplates_batches_path
  end

  private

  def digital_bookplates_batch_params
    params.require(:digital_bookplates_batch)
          .permit(:file_obj, :druid, :user_email, :user_name, :submit_date, :batch_type)
  end

  def new_path_redirect(digital_bookplates_batch_params)
    if digital_bookplates_batch_params[:batch_type] == 'add'
      add_batch_new_digital_bookplates_batch_path
    else
      delete_batch_new_digital_bookplates_batch_path
    end
  end

  def copy_file(file_obj, batch_id)
    FileUtils.chmod 0o644, file_obj.path
    file = file_obj.path
    symphony_path = Settings.symphony_dataload_digital_bookplates
    new_file = "#{symphony_path}/#{batch_id}_#{file_obj.original_filename}"
    FileUtils.cp(file, new_file, preserve: true)
  end

  def delete_file(ckey_file, batch_id)
    file_path = "#{Settings.symphony_dataload_digital_bookplates}/#{batch_id}_#{ckey_file}"
    FileUtils.rm(file_path)
  end
end
