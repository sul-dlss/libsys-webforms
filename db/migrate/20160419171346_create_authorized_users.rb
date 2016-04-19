class CreateAuthorizedUsers < ActiveRecord::Migration
  def change
    create_table :authorized_users do |t|
      t.string :user_id
      t.string :user_name
      t.string :unicorn_updates
      t.string :direct_upload
      t.string :unicorn_circ_batch
      t.string :priv_approval
      t.string :email_stats
      t.string :priv_support
      t.string :db_access_ids
      t.string :priceforbills
      t.string :reset_recall_counter
      t.string :mgt_rpts
      t.string :ora_admin
      t.string :sal3_batch_req
      t.string :file_upload

      t.timestamps null: false
    end
  end
end
