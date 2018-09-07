class CreateUniUpdMhldErrors < ActiveRecord::Migration
  def change
    create_table :uni_upd_mhld_errors do |t|
      t.integer :batch_id
      t.string :flex
      t.string :err_msg
      t.string :format
      t.string :old_lib
      t.string :new_lib
      t.string :new_loc
    end
  end
end
