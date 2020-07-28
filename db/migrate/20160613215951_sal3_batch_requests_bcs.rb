class Sal3BatchRequestsBcs < ActiveRecord::Migration[5.0]
  def change
    create_table :sal3_batch_requests_bcs do |t|
      t.integer   :batch_id
      t.string    :pending
      t.datetime  :load_date
      t.integer   :priority
      t.string    :item_id
      t.datetime  :run_date
      t.datetime  :completed_date

      t.timestamps null: false
    end
  end
end
