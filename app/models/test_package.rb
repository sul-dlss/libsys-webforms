###
#  Class to connect to the VND_PACKAGES table on LTRXDEV2
###
class TestPackage < ApplicationRecord
  establish_connection :morison if Rails.env.production?
  self.table_name = 'vnd_packages'
  self.primary_key = 'record_id'

  private

  def timestamp_attributes_for_create
    super << :date_entered
  end

  def timestamp_attributes_for_update
    super << :date_modified
  end
end
