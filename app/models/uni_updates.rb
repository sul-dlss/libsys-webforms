###
#  Class to connect to the UNI_UPDATES table in Symphony
###
class UniUpdates < ActiveRecord::Base
  self.table_name = 'uni_updates'
  self.primary_key = 'batch_id'
  belongs_to :uni_updates_batch, foreign_key: 'batch_id', class_name: UniUpdatesBatch

  # rubocop:disable Metrics/MethodLength
  def self.create_for_batch(array_of_item_ids, uni_updates_batch)
    hashes_for_updates = []
    array_of_item_ids.each do |item_id|
      hashes_for_updates << {
        batch_id: uni_updates_batch.batch_id,
        export_yn: uni_updates_batch.export_yn,
        priority: uni_updates_batch.priority,
        action: uni_updates_batch.action,
        item_id: item_id,
        cur_lib: uni_updates_batch.orig_lib,
        new_lib: uni_updates_batch.new_lib,
        new_itype: uni_updates_batch.new_itype,
        new_homeloc: uni_updates_batch.new_homeloc,
        new_curloc: uni_updates_batch.new_curloc,
        check_bc_first: uni_updates_batch.check_bc_first,
        pending: 'Y'
      }
    end
    UniUpdates.create(hashes_for_updates)
  end
  # rubocop:enable Metrics/MethodLength

  def self.filter_duplicates(item_ids)
    uniques = []
    duplicates = []
    item_ids.each do |item_id|
      if UniUpdates.where(item_id: item_id).empty?
        uniques << item_id
      else
        duplicates << item_id
      end
    end
    [uniques, duplicates]
  end
end
