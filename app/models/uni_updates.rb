###
#  Class to connect to the UNI_UPDATES table in Symphony
###
class UniUpdates < ApplicationRecord
  self.table_name = 'uni_updates'
  self.primary_key = 'batch_id'
  belongs_to :uni_updates_batch, class_name: 'UniUpdatesBatch',
                                 inverse_of: :uni_updates

  def self.create_for_batch(array_of_item_ids, uni_updates_batch)
    hashes_for_updates = []
    array_of_item_ids.each do |item_id|
      hashes_for_updates << {
        batch_id: uni_updates_batch.batch_id,
        load_date: uni_updates_batch.batch_date,
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

  def self.filter_duplicates(item_ids)
    uniq_item_ids = item_ids.uniq
    uniques = []
    duplicates = []
    uniq_item_ids.each do |item_id|
      count = UniUpdates.where('item_id = ? AND load_date = trunc(sysdate)', item_id).count
      if count.zero?
        uniques << item_id
      else
        duplicates << item_id
      end
    rescue ActiveRecord::StatementInvalid
    end
    [uniques, duplicates]
  end
end
