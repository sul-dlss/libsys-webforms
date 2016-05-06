class CreateUniUpdatesBatch < ActiveRecord::Migration
  def change
    create_table :uni_updates_batch do |t|
      t.integer :batch_id
      t.datetime :batch_date
      t.string :user_name
      t.string :user_email
      t.string :action
      t.integer :priority
      t.string :export_yn
      t.string :check_bc_first
      t.string :orig_lib
      t.string :new_lib
      t.string :new_homeloc
      t.string :new_curloc
      t.string :new_itype
      t.integer :total_bcs
      t.string :pending
      t.string :comments
      t.integer :num_errors

      t.timestamps null: false
    end
  end
end
