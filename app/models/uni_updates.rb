###
#  Class to connect to the UNI_UPDATES table in Symphony
###
class UniUpdates < ActiveRecord::Base
  self.table_name = 'uni_updates'
  self.primary_key = 'batch_id'
  belongs_to :uni_updates_batch, foreign_key: 'batch_id', class_name: UniUpdatesBatch

  # rubocop:disable Metrics/MethodLength
  def self.create_item_type_updates(array_of_item_ids, uni_updates_batch)
    hashes_for_updates = []
    array_of_item_ids.each do |item_id|
      hashes_for_updates << {  batch_id: uni_updates_batch.batch_id,
                               export_yn: uni_updates_batch.export_yn,
                               priority: uni_updates_batch.priority,
                               action: uni_updates_batch.action,
                               item_id: item_id,
                               cur_lib: uni_updates_batch.orig_lib,
                               new_itype: uni_updates_batch.new_itype,
                               check_bc_first: uni_updates_batch.check_bc_first
                            }
    end
    UniUpdates.create(hashes_for_updates)
  end
  # rubocop:enable Metrics/MethodLength
end
