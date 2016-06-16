class Sal3BatchRequestsBatch < ActiveRecord::Migration
  def change
    create_table :sal3_batch_requests_batch do |t|
      t.integer   :batch_id
      t.string    :batch_name
      t.string    :user_name
      t.string    :user_email
      t.string    :user_phone
      t.string    :user_sunetid
      t.string    :status
      t.integer   :priority
      t.string    :batch_container
      t.string    :batch_media
      t.datetime  :batch_startdate
      t.datetime  :batch_needbydate
      t.integer   :batch_numpullperday
      t.string    :batch_pullmon
      t.string    :batch_pulltues
      t.string    :batch_pullwed
      t.string    :batch_pullthurs
      t.string    :batch_pullfri
      t.string    :stopcode
      t.string    :pseudo_id
      t.string    :comments
      t.integer   :ckey
      t.string    :bc_file
      t.integer   :num_bcs
      t.integer   :num_nonsymph_bcs
      t.integer   :num_retrieval_err
      t.string    :pending
      t.datetime  :load_date
      t.datetime  :last_action_date

      t.timestamps null: false
    end
  end
end
