class CreateVndRunlogs < ActiveRecord::Migration
  def change
    create_table :vnd_runlog do |t|
      t.datetime :run_date
      t.string :procedure_name
      t.string :priority
      t.string :message
      t.string :vendor_name
      t.string :action_type
      t.integer :seq_number
      t.string :file_name
      t.string :note
      t.timestamps null: false
    end
  end
end
