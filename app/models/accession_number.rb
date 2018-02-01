###
# Accession numbers for cataloging
###
class AccessionNumber < ActiveRecord::Base
  self.table_name = 'catnums'

  validates :item_type, :location, :prefix, presence: true
end
