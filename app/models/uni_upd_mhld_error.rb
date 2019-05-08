###
#  Class to connect to the UNI_UPD_MHLD_ERRORS table in Symphony
###
class UniUpdMhldError < ApplicationRecord
  self.table_name = 'uni_upd_mhld_errors'

  def self.errors_for_mhld(batch)
    where("BATCH = #{batch}")
  end
end
