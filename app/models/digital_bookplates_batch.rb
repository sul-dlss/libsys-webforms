###
#  Class to connect to the DIGITAL_BOOKPLATES_BATCH table
###
class DigitalBookplatesBatch < ActiveRecord::Base
  self.table_name = 'digital_bookplates_batches'
  self.primary_key = 'batch_id'
  attr_accessor :file_obj

  validates :file_obj, :druid, :user_name, :batch_type, presence: true, on: :create

  before_destroy :in_queue_batch?

  private

  def in_queue_batch?
    completed_date.nil?
  end
end
