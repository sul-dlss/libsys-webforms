###
#  Class to connect to the UNI_UPDATES_BATCH table in Symphony
###
class UniUpdatesBatch < ActiveRecord::Base
  self.table_name = 'uni_updates_batch'
  self.primary_key = 'batch_id'
  has_many :uni_updates, foreign_key: 'batch_id', class_name: UniUpdates

  # rubocop:disable Metrics/AbcSize
  def self.create_item_type_batch(params)
    create(batch_date: params[:change_item_type][:batch_date],
           user_name: params[:change_item_type][:user_name],
           user_email: params[:change_item_type][:email],
           orig_lib: params[:change_item_type][:current_library],
           action: params[:change_item_type][:action],
           priority: params[:change_item_type][:priority],
           export_yn: params[:change_item_type][:export_yn],
           new_itype: params[:change_item_type][:new_item_type],
           check_bc_first: params[:change_item_type][:check_bc_first],
           comments: params[:change_item_type][:comments])
  end
  # rubocop:enable Metrics/AbcSize
end
