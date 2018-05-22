###
#  Class to connect to the UNI_UPDATES table in Symphony
###
class Sal3BatchRequestBcs < ActiveRecord::Base
  self.table_name = 'sal3_batch_requests_bcs'
  self.primary_key = 'batch_id'
  belongs_to :sal3_batch_requests_batch, foreign_key: 'batch_id', class_name: Sal3BatchRequestsBatch, inverse_of: false

  def self.create_sal3_request(array_of_item_ids, sal3_batch_request)
    hashes_for_updates = []
    array_of_item_ids.each do |item_id|
      hashes_for_updates << hash_for_update(item_id, sal3_batch_request)
    end
    Sal3BatchRequestBcs.create(hashes_for_updates)
  end

  def self.hash_for_update(item_id, sal3_batch_request)
    {
      batch_id: sal3_batch_request[:batch_id],
      pending: sal3_batch_request[:pending],
      load_date: sal3_batch_request[:load_date],
      priority: sal3_batch_request[:priority],
      item_id: item_id,
      completed_date: sal3_batch_request[:completed_date]
    }
  end

  def self.barcodes(item_id)
    Sal3BatchRequestBcs.joins(:sal3_batch_requests_batch).where(batch_id: item_id)
  end
end
