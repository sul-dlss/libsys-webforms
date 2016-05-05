###
#  Class to connect to the UNI_UPDATES_BATCH table in Symphony
###
class UniUpdatesBatch < ActiveRecord::Base
  self.table_name = 'uni_updates_batch'
  self.primary_key = 'batch_id'
  has_many :uni_updates, foreign_key: 'batch_id', class_name: UniUpdates
end
