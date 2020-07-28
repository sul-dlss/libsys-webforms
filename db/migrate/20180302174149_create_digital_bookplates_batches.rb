class CreateDigitalBookplatesBatches < ActiveRecord::Migration[5.0]
  def change
    create_table :digital_bookplates_batches, primary_key: 'batch_id' do |t|
      t.string :ckey_file
      t.string :druid
      t.string :user_name
      t.string :user_email
      t.string :batch_type
      t.integer :ckey_count
      t.datetime :submit_date
      t.datetime :completed_date

      t.timestamps null: false
    end
  end
end
