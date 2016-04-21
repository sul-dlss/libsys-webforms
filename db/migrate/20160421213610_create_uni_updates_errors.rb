class CreateUniUpdatesErrors < ActiveRecord::Migration
  def change
    create_table :uni_updates_errors do |t|
      t.string :run
      t.string :batch
      t.string :item_id
      t.string :call_num
      t.string :shelving_key
      t.string :msg
    end
  end
end
