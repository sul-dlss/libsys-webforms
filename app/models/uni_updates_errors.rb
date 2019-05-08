###
#  Class to connect to the UNI_UPDATES_ERRORS table in Symphony
###
class UniUpdatesErrors < ApplicationRecord
  self.table_name = 'uni_updates_errors'

  def self.errors_for_batch(batch)
    where("BATCH = #{batch}")
  end
end
