class CreateShelfSelectionItemType < ActiveRecord::Migration
  def change
    create_table :shelf_sel_item_types do |t|
      t.string :item_type
    end
  end
end
