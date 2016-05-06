###
#  Class to connect to the UNI_UPDATES table in Symphony
###
class UniUpdates < ActiveRecord::Base
  self.table_name = 'uni_updates'
  self.primary_key = 'batch_id'
  belongs_to :uni_updates_batch, foreign_key: 'batch_id'
end
