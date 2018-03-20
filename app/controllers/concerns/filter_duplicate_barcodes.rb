###
# Utilities to Filter duplicate barcodes from UniUpdates
###
module FilterDuplicateBarcodes
  extend ActiveSupport::Concern

  def self.filtered_item_ids(array_of_item_ids)
    UniUpdates.filter_duplicates(array_of_item_ids)
  end
end
