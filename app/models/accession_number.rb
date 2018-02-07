###
# Accession numbers for cataloging
###
class AccessionNumber < ActiveRecord::Base
  self.table_name = 'catnums'
  attr_accessor :seq_num_incrementer

  validates :item_type, :location, :prefix, presence: true
end
