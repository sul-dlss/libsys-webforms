class CreateShelfSelectionItemType < ActiveRecord::Migration[5.0]
  def change
    create_table :shelf_sel_item_types do |t|
      t.string :item_type
    end
  end
end
