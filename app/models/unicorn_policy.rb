###
#  Class to connect to the UNICORN_POLICIES table in Symphony
###
class UnicornPolicy < ActiveRecord::Base
  self.table_name = 'unicorn_policies'
  self.inheritance_column = nil

  def self.libraries
    where(type: 'LIBR').order(:name)
  end

  def self.item_types
    where(type: 'ITYP').order(:name)
  end

  def self.locations
    where(type: 'LOCN').order(:name)
  end
end
