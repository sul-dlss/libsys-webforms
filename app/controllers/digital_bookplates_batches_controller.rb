# Controller to show, create, and edit digital bookplate batches
class DigitalBookplatesBatchesController < ApplicationController
  load_and_authorize_resource

  def index() end

  def queue
    @digital_bookplates_batches = DigitalBookplatesBatch.all.where(completed_date: [nil])
                                                        .order('submit_date DESC')
  end

  def completed
    @digital_bookplates_batches = DigitalBookplatesBatch.all.where.not(completed_date: [nil])
                                                        .order('completed_date DESC')
  end

  def add_batch
    @digital_bookplates_batch = DigitalBookplatesBatch.new
  end

  def delete_batch
    @digital_bookplates_batch = DigitalBookplatesBatch.new
  end

  def create
    file_obj = digital_bookplates_batch_params[:file_obj]
    @digital_bookplates_batch = DigitalBookplatesBatch.new(digital_bookplates_batch_params)
    @digital_bookplates_batch.file = file_obj.original_filename unless file_obj.nil?
    num_ckeys = count_ckeys(file_obj)
    if num_ckeys <= 10_000
      @digital_bookplates_batch.ckey_count = num_ckeys
      copy_file(file_obj, @digital_bookplates_batch.submit_date.strftime('%Y%m%d%H%M%S'))
      @digital_bookplates_batch.save
      redirect_to queue_digital_bookplates_batches_path
      flash[:notice] = 'Batch uploaded!'
    else
      flash[:error] = 'Too many ckeys in the file! Limit is 10,000 ckeys.'
      if digital_bookplates_batch_params[:batch_type] == 'add'
        render action: 'add_batch'
      else
        render action: 'delete_batch'
      end
    end
  end

  def destroy
    @digital_bookplates_batch = DigitalBookplatesBatch.find_by(batch_id: params[:id])
    if @digital_bookplates_batch.destroy
      delete_file(@digital_bookplates_batch.file, @digital_bookplates_batch.submit_date.strftime('%Y%m%d%H%M%S'))
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

  def count_ckeys(file_obj)
    ckeys = IO.read(file_obj.path).split("\n").uniq.length
    ckeys
  end

  def copy_file(file_obj, submit_date)
    FileUtils.chmod 0o644, file_obj.path
    file = file_obj.path
    symphony_path = Settings.symphony_dataload_digital_bookplates
    new_file = "#{symphony_path}/#{submit_date}_#{file_obj.original_filename}"
    FileUtils.cp(file, new_file, preserve: true)
  end

  def delete_file(file, submit_date)
    file_path = "#{Settings.symphony_dataload_digital_bookplates}/#{submit_date}_#{file}"
    FileUtils.rm(file_path)
  end
end
