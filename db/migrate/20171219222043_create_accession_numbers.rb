class CreateAccessionNumbers < ActiveRecord::Migration
  def change
    create_table :catnums do |t|
      t.string :item_type
      t.string :location
      t.string :prefix
      t.integer :seq_num
      t.string :resource_type

      t.timestamps null: false
    end
  end
end
