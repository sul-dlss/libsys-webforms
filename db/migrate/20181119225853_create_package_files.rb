class CreatePackageFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :vnd_files_gen do |t|
      t.string :package_id
      t.string :vendor_name
      t.integer :seq_number
      t.string :package_status
      t.string :file_name
      t.datetime :date_created
      t.string :new_file_name
      t.integer :file_size_bytes
      t.string :file_type
      t.string :vnd_file_function
      t.datetime :date_extracted
      t.datetime :date_of_action
      t.datetime :date_ftpd
      t.datetime :date_to_load
      t.string :place_to_load
      t.datetime :date_loaded
      t.string :record_source
      t.string :status_ftp
      t.string :status_load
      t.string :parms_used
      t.integer :count_of_titles
      t.string :note
      t.string :remote_dir
      t.timestamps null: false
    end
  end
end
