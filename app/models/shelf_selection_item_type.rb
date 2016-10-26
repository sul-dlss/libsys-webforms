# app/models/shelf_selection_item_type.rb
class ShelfSelectionItemType < ActiveRecord::Base
  self.table_name = 'shelf_sel_item_types'

  def self.item_types
    select(:item_type).distinct.order(:item_type).pluck(:item_type).sort.unshift('All Item Types')
  end
end
