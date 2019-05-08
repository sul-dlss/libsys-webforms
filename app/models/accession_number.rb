###
# Accession numbers for cataloging
###
class AccessionNumber < ApplicationRecord
  self.table_name = 'catnums'
  self.primary_key = 'id'

  # catnums has sequence name 'catnums_seq' in order to increment primary key by 1

  attr_accessor :seq_num_incrementer

  validates :item_type, :location, :prefix, presence: true
end
