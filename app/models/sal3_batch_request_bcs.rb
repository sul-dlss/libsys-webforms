###
#  Class to connect to the UNI_UPDATES table in Symphony
###
class Sal3BatchRequestBcs < ActiveRecord::Base
  self.table_name = 'sal3_batch_requests_bcs'
  self.primary_key = 'batch_id'
  belongs_to :sal3_batch_request, foreign_key: 'batch_id', class_name: Sal3BatchRequestsBatch

  # rubocop:disable Metrics/MethodLength
  def self.create_sal3_batch(array_of_item_ids, bc_hash)
    hashes_for_updates = []
    array_of_item_ids.each do |item_id|
      hashes_for_updates << {  batch_id: bc_hash[:batch_id],
                               pending: bc_hash[:pending],
                               load_date: bc_hash[:load_date],
                               priority: bc_hash[:priority],
                               item_id: item_id,
                               run_date: bc_hash[:run_date],
                               completed_date: bc_hash[:completed_date]
                            }
    end
    Sal3BatchRequestBcs.create(hashes_for_updates)
  end
  # rubocop:enable Metrics/MethodLength
end
