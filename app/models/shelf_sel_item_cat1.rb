# app/models/shelf_sel_item_cat1.rb
class ShelfSelItemCat1 < ApplicationRecord
  self.table_name = 'shelf_sel_item_cat1s'

  def self.item_category1s
    select(:item_category1).distinct.order(:item_category1).pluck(:item_category1).sort.unshift('All Item Category1s')
  end
end
