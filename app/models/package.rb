###
#  Class to connect to the VND_PACKAGES table
###
class Package < ActiveRecord::Base
  self.table_name = 'vnd_packages'
  self.primary_key = 'record_id'

  validates :record_id, uniqueness: true
  validates :package_name, :vendor_name, :data_pickup_type, :package_status, presence: true
end
