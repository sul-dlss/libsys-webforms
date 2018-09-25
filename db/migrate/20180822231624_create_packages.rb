class CreatePackages < ActiveRecord::Migration
  def change
    create_table :vnd_packages, :primary_key => :record_id do |t|
      t.string :package_id
      t.string :package_name
      t.string :package_status
      t.string :data_pickup_type
      t.string :afs_path
      t.string :ftp_server
      t.string :ftp_user
      t.string :ftp_password
      t.string :ftp_directory
      t.string :ftp_file_prefix
      t.string :ftp_list_type
      t.string :package_url
      t.datetime :date_entered
      t.string :vendor_name
      t.string :holding_code
      t.string :comments
      t.datetime :date_modified
      t.string :put_file_loc
      t.string :afs_search_string
      t.string :url_field
      t.string :vendor_id_read
      t.string :vendor_id_write
      t.string :access_note
      t.string :export_note
      t.string :junktag_file
      t.string :encoding_level
      t.string :vnd_catcode
      t.string :match_opts
      t.string :proc_type
      t.string :update_040
      t.string :rpt_mail
      t.string :access_urls_plats
      t.string :date_cat
      t.string :export_auth
      t.string :preprocess_modify_script
      t.string :preprocess_split_script
      t.string :preprocess_put_script

      t.timestamps null: false
    end
  end
end
