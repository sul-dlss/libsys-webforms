class CreateUniUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :uni_updates do |t|
      t.integer :batch_id
      t.string :pending
      t.string :export_yn
      t.datetime :load_date
      t.integer :priority
      t.string :action
      t.string :item_id
      t.datetime :run_date
      t.string :to_delete_date
      t.datetime :completed_date
      t.string :cur_lib
      t.string :new_lib
      t.string :new_itype
      t.string :new_homeloc
      t.string :new_curloc
      t.string :check_bc_first

      t.timestamps null: false
    end
  end
end
