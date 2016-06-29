class CreateShelfSelItemCat1 < ActiveRecord::Migration
  def change
    create_table :shelf_sel_item_cat1s do |t|
      t.string :item_category1
    end
  end
end
