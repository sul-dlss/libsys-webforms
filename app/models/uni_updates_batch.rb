###
#  Class to connect to the UNI_UPDATES_BATCH table in Symphony
###
class UniUpdatesBatch < ActiveRecord::Base
  self.table_name = 'uni_updates_batch'
end
